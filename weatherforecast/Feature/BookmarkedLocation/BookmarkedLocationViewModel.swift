//
//  BookmarkedLocationViewModel.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Observable

final class BookmarkedLocationViewModel {

	struct BookmarkItem {
		let locationName: String
		let windSpeed: Int
		let windDegree: Int
		let humidity: Int
		let temperature: Int
	}

	weak var navigationDelegate: BookmarkedLocationViewControllerNavigationDelegate?
	
	var numberOfRows: Int {
		return itemsSubject.value.count
	}
	
	var items: ImmutableObservable<[BookmarkItem]> {
		return itemsSubject
	}
	
	private let localBookmarkRepository: BookmarkLocationRepository
	private let openWeatherRepository: WeatherRepository
	private let itemsSubject: Observable<[BookmarkItem]> = Observable([])

	init(localBookmarkRepository: BookmarkLocationRepository,
		 openWeatherRepository: WeatherRepository) {
		self.localBookmarkRepository = localBookmarkRepository
		self.openWeatherRepository = openWeatherRepository
	}

	func retrieveBookmarkedLocations() {
		localBookmarkRepository.retrieveAllLocations { [weak self] (result) in
			switch result {
			case .success(let placeInfos):
				self?.retrieveWeatherInfo(placeInfos: placeInfos)
			case .failure(let error):
				self?.navigationDelegate?.showErrorMessage(error.localizedDescription)
			}
		}
	}

	func showAddLocation() {
		navigationDelegate?.showAddLocation()
	}

	func showDetailWeatherInfo() {
		navigationDelegate?.showDetailWeatherInfo()
	}
	
	
	private func retrieveWeatherInfo(placeInfos: [PlaceInfo]) {
		let cityIds = placeInfos.map { $0.identifier }
		let uniqueCityIds = Set(cityIds).map { $0 }
		openWeatherRepository.weatherForecastByCityIds(uniqueCityIds) { [weak self] (result) in
			switch result {
			case .success(let infoList):
				self?.itemsSubject.value = infoList.infos.map { BookmarkItem(locationName: $0.cityName,
																			windSpeed: Int($0.wind.speed),
																			windDegree: Int($0.wind.degree),
																			humidity: Int($0.mainInfo.humidity),
																			temperature: Int($0.mainInfo.temperature)) }
			case .failure(let error):
				self?.navigationDelegate?.showErrorMessage(error.localizedDescription)
			}
		}
	}
	
}
