//
//  AddLocationViewModel.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Observable
import CoreLocation

final class AddLocationViewModel {

	// MARK: - Public Properties
	
	var currentLocation: ImmutableObservable<CLLocation?> {
		return currentLocationSubject
	}
	
	var isAbleToBookmarkLocation: ImmutableObservable<Bool> {
		return isAbleToBookmarkLocationSubject
	}
	
	var isLoading: ImmutableObservable<Bool> {
		return isLoadingSubject
	}
	
	// MARK: - Private Properties
	
	private let deviceLocationHandler: DeviceLocationHandling
	private let weatherRepository: WeatherRepository
	private let localBookmarkRepository: BookmarkLocationRepository
	
	private let currentLocationSubject: Observable<CLLocation?> = Observable(nil)
	private let errorMessageSubject: Observable<String?> = Observable(nil)
	private let isAbleToBookmarkLocationSubject = Observable(false)
	private let isLoadingSubject = Observable(false)
	
	private var selectedCoordinate: CLLocationCoordinate2D? {
		didSet {
			isAbleToBookmarkLocationSubject.value = selectedCoordinate != nil
		}
	}
	
	// MARK: - Constructor
	
	init(deviceLocationHandler: DeviceLocationHandling,
		 weatherRepository: WeatherRepository,
		 localBookmarkRepository: BookmarkLocationRepository) {
		self.deviceLocationHandler = deviceLocationHandler
		self.weatherRepository = weatherRepository
		self.localBookmarkRepository = localBookmarkRepository
	}

	// MARK: - Public Methods
	
	func requestLocation() {
		deviceLocationHandler.requestLocation { [weak self] (result) in
			switch result {
			case .success(let location):
				self?.currentLocationSubject.value = location
			case .failure(let error):
				self?.errorMessageSubject.value = error.localizedDescription
			}
		}
	}

	func selectCoordinate(_ coordinate: CLLocationCoordinate2D) {
		selectedCoordinate = coordinate
	}

	func saveLocation() {
		guard let selectedCoordinate = selectedCoordinate else { return }
		isLoadingSubject.value = true
		weatherRepository.retrievePlaceInformation(latitude: selectedCoordinate.latitude,
												   longitude: selectedCoordinate.longitude) { [weak self] (result) in
													self?.isLoadingSubject.value = false
													switch result {
													case .success(let placeInfo):
														self?.bookmarkLocation(placeInfo)
													case .failure(let error):
														print("\(error)")
													}
		}
	}
	
	private func bookmarkLocation(_ placeInfo: PlaceInfo) {
//		isLoadingSubject.value = true
		self.localBookmarkRepository.saveLocation(placeInfo) { [weak self] (result) in
//			self?.isLoadingSubject.value = false
			switch result {
			case .success:
				print("Success")
			case .failure(let error):
				print("Error: \(error)")
			}
		}
	}
}
