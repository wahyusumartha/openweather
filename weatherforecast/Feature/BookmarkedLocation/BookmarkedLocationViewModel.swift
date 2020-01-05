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
		let windDegree: Double
		let humidity: Int
		let temperature: Int
		let iconUrl: URL?
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
	private let selectedWeatherInfoHandler: SelectedWeatherInfoHandling
	private let itemsSubject: Observable<[BookmarkItem]> = Observable([])
	private var infoList: [AggregatedWeatherInfo] = []

	init(localBookmarkRepository: BookmarkLocationRepository,
		 openWeatherRepository: WeatherRepository,
		 selectedWeatherInfoHandler: SelectedWeatherInfoHandling) {
		self.localBookmarkRepository = localBookmarkRepository
		self.openWeatherRepository = openWeatherRepository
		self.selectedWeatherInfoHandler = selectedWeatherInfoHandler
	}

	func retrieveBookmarkedLocations() {
		localBookmarkRepository.retrieveAllLocations { [weak self] (result) in
			switch result {
			case .success(let placeInfos):
				guard !placeInfos.isEmpty else { return }
				self?.retrieveWeatherInfo(placeInfos: placeInfos)
			case .failure(let error):
				self?.navigationDelegate?.showErrorMessage(error.localizedDescription)
			}
		}
	}

	func showAddLocation() {
		navigationDelegate?.showAddLocation()
	}

	func showDetailWeatherInfo(at indexPath: IndexPath) {
		let selectedWeatherInfo = infoList[indexPath.row]
		selectedWeatherInfoHandler.updateSelectedWeatherInfo(selectedWeatherInfo)
		navigationDelegate?.showDetailWeatherInfo()
	}

	func showHelpScreen() {
		navigationDelegate?.showHelpScreen()
	}

	func deleteBookmark(at indexPath: IndexPath) {
		guard let cityId = infoList[indexPath.row].cityId
		else {
			return
		}
		
		localBookmarkRepository.removeLocation(cityId: cityId) { [weak self] (result) in
			switch result {
			case .success:
				let newInfoList = infoList.filter { $0.cityId != cityId }
				self?.infoList = newInfoList
				self?.itemsSubject.value = newInfoList.map { BookmarkItem(locationName: $0.cityName ?? "",
																		  windSpeed: Int($0.wind.speed),
																		  windDegree: $0.wind.degree,
																		  humidity: Int($0.mainInfo.humidity),
																		  temperature: Int($0.mainInfo.temperature),
																		  iconUrl: $0.weathers.first?.iconUrl ?? nil) }
			case .failure(let error):
				self?.navigationDelegate?.showErrorMessage(error.localizedDescription)
			}
		}
	}
	
	private func retrieveWeatherInfo(placeInfos: [PlaceInfo]) {
		let cityIds = placeInfos.map { $0.identifier }
		let uniqueCityIds = Set(cityIds).map { $0 }
		openWeatherRepository.weatherForecastByCityIds(uniqueCityIds) { [weak self] (result) in
			switch result {
			case .success(let infoList):
				self?.infoList = infoList.infos
				self?.itemsSubject.value = infoList.infos.map { BookmarkItem(locationName: $0.cityName ?? "",
																			windSpeed: Int($0.wind.speed),
																			windDegree: $0.wind.degree,
																			humidity: Int($0.mainInfo.humidity),
																			temperature: Int($0.mainInfo.temperature),
																			iconUrl: $0.weathers.first?.iconUrl ?? nil) }
			case .failure(let error):
				self?.navigationDelegate?.showErrorMessage(error.localizedDescription)
			}
		}
	}
}
