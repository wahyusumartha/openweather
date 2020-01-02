//
//  AddLocationViewController.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit
import MapKit
import Observable

final class AddLocationViewController: UIViewController {

	// MARK: - Private Properties
	
	private let mapView: MKMapView = {
		let mapView = MKMapView()
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapView.showsUserLocation = true
		return mapView
	}()

	private let bookmarkButton: UIButton = {
		let bookmarkButton = UIButton()
		bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
		bookmarkButton.backgroundColor = .actionBlue900
		bookmarkButton.setTitleColor(.authenticBlue50, for: .normal)
		bookmarkButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		bookmarkButton.setTitle("Bookmark", for: .normal)
		bookmarkButton.layer.cornerRadius = 4
		return bookmarkButton
	}()

	private let progressIndicatorView: UIActivityIndicatorView = {
		let progressIndicatorView: UIActivityIndicatorView
		if #available(iOS 13.0, *) {
			progressIndicatorView = UIActivityIndicatorView(style: .large)
		} else {
			progressIndicatorView = UIActivityIndicatorView(style: .gray)
		}
		
		progressIndicatorView.hidesWhenStopped = true
		progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
		return progressIndicatorView
	}()
	
	private let viewModel: AddLocationViewModel
	private var disposal = Disposal()
	
	// MARK: - Constructor
	
	init(viewModel: AddLocationViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycles
	
	override func viewDidLoad() {
        super.viewDidLoad()

		setupSubviews()
		setupConstraints()
			
		bindObservable()
		viewModel.requestLocation()
		
		addTapGesture()
	}
    
	
	// MARK: - Private Methods
	
	private func setupSubviews() {
		view.addSubview(mapView)
		view.addSubview(bookmarkButton)
		view.addSubview(progressIndicatorView)
		
		bookmarkButton.addTarget(self, action: #selector(bookmarkButtonDidTap), for: .touchUpInside)
	}
	
	private func setupConstraints() {
		let mapViewConstraints = [
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			mapView.topAnchor.constraint(equalTo: view.topAnchor)
		]
		
		let bookmarkButtonConstraints = [
			bookmarkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			bookmarkButton.widthAnchor.constraint(equalToConstant: 200),
			bookmarkButton.heightAnchor.constraint(equalToConstant: 44),
			bookmarkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		]
		
		let progressIndicatorViewConstraints = [
			progressIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			progressIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		]
	
		let activeConstraints = mapViewConstraints + bookmarkButtonConstraints + progressIndicatorViewConstraints
		NSLayoutConstraint.activate(activeConstraints)
	}
	
	private func bindObservable() {
		viewModel.currentLocation.observe { [weak self] (location, _) in
			guard let location = location else { return }
			self?.centerMapOnLocation(location)
		}.add(to: &disposal)
		
		viewModel.isAbleToBookmarkLocation.observe { [weak self] (isAbleToBookmarkLocation, _) in
			self?.bookmarkButton.isHidden = !isAbleToBookmarkLocation
		}.add(to: &disposal)
	
		viewModel.isLoading.observe(.main) { [weak self] (isLoading, _) in
			if isLoading {
				self?.progressIndicatorView.startAnimating()
			} else {
				self?.progressIndicatorView.stopAnimating()
			}
		}.add(to: &disposal)
	}

	private func centerMapOnLocation(_ location: CLLocation) {
		let regionRadius: CLLocationDistance = 1000
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
												  latitudinalMeters: regionRadius,
												  longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: true)
	}
	
	private func addTapGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnMap(_:)))
		mapView.addGestureRecognizer(tapGesture)
	}
	
	@objc private func tapOnMap(_ sender: UITapGestureRecognizer) {
		guard sender.state == .ended else { return }
		let locationInView = sender.location(in: mapView)
		let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
		addAnnotation(at: tappedCoordinate)
		
		viewModel.selectCoordinate(tappedCoordinate)
	}
	
	private func addAnnotation(at coordinate: CLLocationCoordinate2D) {
		let currentAnnotations = mapView.annotations
		mapView.removeAnnotations(currentAnnotations)
		
		let annotation = MKPointAnnotation()
		annotation.coordinate = coordinate
		mapView.addAnnotation(annotation)
	}
	
	@objc private func bookmarkButtonDidTap() {
		viewModel.saveLocation()
	}
}
