//
//  BookmarkedLocationViewModel.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Observable

struct BookmarkedLocationViewModel {

	struct BookmarkItem {
		let locationName: String
		let windSpeed: Double
		let windDegree: Double
		let humidity: Double
		let temperature: Double
	}

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
		localBookmarkRepository.retrieveAllLocations { (result) in
			switch result {
			case .success(let placeInfos):
				retrieveWeatherInfo(placeInfos: placeInfos)
			case .failure(let error):
				print("\(error.localizedDescription)")
			}
		}
	}
	
	private func retrieveWeatherInfo(placeInfos: [PlaceInfo]) {
		let cityIds = placeInfos.map { $0.identifier }
		let uniqueCityIds = Set(cityIds).map { $0 }
		openWeatherRepository.weatherForecastByCityIds(uniqueCityIds) { (result) in
			switch result {
			case .success(let infoList):
				self.itemsSubject.value = infoList.infos.map { BookmarkItem(locationName: $0.cityName,
																			windSpeed: $0.wind.speed,
																			windDegree: $0.wind.degree,
																			humidity: $0.mainInfo.humidity,
																			temperature: $0.mainInfo.temperature) }
			case .failure(let error):
				print("List Error: \(error.localizedDescription)")
			}
		}
	}
	
}
