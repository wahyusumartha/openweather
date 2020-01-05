//
//  DetailWeatherInfoViewModel.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Observable

final class DetailWeatherInfoViewModel {

	weak var navigationDelegate: DetailWeatherInfoViewControllerNavigationDelegate?
	
	struct DetailWeatherHeaderItem {
		let locationName: String
		let weatherInfo: String
		let iconURL: URL?
	}
	
	struct WeatherForecastItem {
		let dateAsString: String
		let temperature: String
		let humidity: String
		let rainChances: String
		let windSpeed: String
	}
	
	var weatherInformations: [(title: String, info: String)] {
		guard let selectedWeatherInfo = selectedWeatherInfoHandler.selectedWeatherInfo else { return [] }
		
		return [("temperature_title".localized, String(format: "temperature_in_metrics_format".localized, "\(Int(selectedWeatherInfo.mainInfo.temperature))")),
				("humidity_title".localized, String(format: "humidity_percentage".localized, "\(Int(selectedWeatherInfo.mainInfo.humidity))")),
				("chances_of_rain_title".localized, String(format: "chances_of_rain".localized, "\(Int(selectedWeatherInfo.cloud.cloudinessPercentage))")),
				("wind_speed_title".localized, String(format: "wind_speed_in_metrics_format".localized, "\(Int(selectedWeatherInfo.wind.speed))"))
		]
	}
	
	var items: ImmutableObservable<[WeatherForecastItem]> {
		return itemsSubject
	}
	
	var headerItem: DetailWeatherHeaderItem {
		let selectedWeatherInfo = selectedWeatherInfoHandler.selectedWeatherInfo
		return DetailWeatherHeaderItem(locationName: selectedWeatherInfo?.cityName ?? "",
									   weatherInfo: selectedWeatherInfo?.weathers.first?.condition ?? "",
									   iconURL: selectedWeatherInfo?.weathers.first?.iconUrl)
	}
	
	private let selectedWeatherInfoHandler: SelectedWeatherInfoHandling
	private let openWeatherRepository: WeatherRepository
	private let itemsSubject: Observable<[WeatherForecastItem]> = Observable([])
	
	init(selectedWeatherInfoHandler: SelectedWeatherInfoHandling,
		 openWeatherRepository: WeatherRepository) {
		self.selectedWeatherInfoHandler = selectedWeatherInfoHandler
		self.openWeatherRepository = openWeatherRepository
	}
	
	func retrieveFiveDaysWeatherForecast() {
		guard let cityId = selectedWeatherInfoHandler.selectedWeatherInfo?.cityId else { return }
		openWeatherRepository.fiveDaysWeatherForecast(cityId: cityId) { [weak self] (result) in
			switch result {
			case .success(let infoList):
				self?.itemsSubject.value = infoList.infos.map {
					WeatherForecastItem(dateAsString: $0.formattedDateAsString,
										temperature: String(format: "temperature_in_metrics_format".localized, "\(Int($0.mainInfo.temperature))"),
										humidity: String(format: "humidity_percentage".localized, "\(Int($0.mainInfo.humidity))"),
										rainChances: String(format: "chances_of_rain".localized, "\(Int($0.cloud.cloudinessPercentage))"),
										windSpeed: String(format: "wind_speed_in_metrics_format".localized, "\(Int($0.wind.speed))"))
				}
			case .failure(let error):
				self?.navigationDelegate?.showErrorMessage(error.localizedDescription)
			}
		}
	}
}
