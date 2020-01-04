//
//  BookmarkedLocationViewController.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit
import Observable

protocol BookmarkedLocationViewControllerNavigationDelegate: AnyObject {
	func showAddLocation()
	func showErrorMessage(_ message: String?)
	func showDetailWeatherInfo()
}

final class BookmarkedLocationViewController: UIViewController {

	weak var navigationDelegate: BookmarkedLocationViewControllerNavigationDelegate? {
		didSet {
			viewModel.navigationDelegate = navigationDelegate
		}
	}

	private let viewModel: BookmarkedLocationViewModel
	private var disposal = Disposal()
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		return tableView
	}()

	init(viewModel: BookmarkedLocationViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		viewModel.retrieveBookmarkedLocations()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
	
		tableView.register(BookmarkedLocationTableViewCell.self,
						   forCellReuseIdentifier: BookmarkedLocationTableViewCell.identifier)
		
		setupSubviews()
		setupConstraints()
		setupRightNavigationBarButtonItem()
		bindObservable()
	}
   
	private func setupSubviews() {
		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)
	}
	
	private func setupConstraints() {
		let tableViewConstraints = [
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		]
		
		NSLayoutConstraint.activate(tableViewConstraints)
	}
	
	private func setupRightNavigationBarButtonItem() {
		let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddLocation))
		rightBarButtonItem.tintColor = .authenticBlue900
		navigationItem.rightBarButtonItem = rightBarButtonItem
	}
	
	@objc private func showAddLocation() {
		viewModel.showAddLocation()
	}
	
	private func bindObservable() {
		viewModel.items.observe { [weak self] (items, _) in
			self?.tableView.reloadData()
		}.add(to: &disposal)
	}
}

extension BookmarkedLocationViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkedLocationTableViewCell.identifier, for: indexPath) as? BookmarkedLocationTableViewCell
		else {
			return UITableViewCell()
		}

		let configurator = BookmarkLocationTableViewCellConfigurator()
		configurator.configureCell(cell,
								   with: viewModel.items.value[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows
	}
}

extension BookmarkedLocationViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.showDetailWeatherInfo()
	}
}
