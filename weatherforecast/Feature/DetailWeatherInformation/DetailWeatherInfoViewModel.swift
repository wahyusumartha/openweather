//
//  DetailWeatherInfoViewModel.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

final class DetailWeatherInfoViewModel {

	struct DetailWeatherHeaderItem {
		let locationName: String
		let weatherInfo: String
		let iconURL: URL?
	}
	
	var weatherInformations: [(title: String, info: String)] {
		guard let selectedWeatherInfo = selectedWeatherInfoHandler.selectedWeatherInfo else { return [] }
		
		return [("temperature_title".localized, String(format: "temperature_in_metrics_format".localized, "\(Int(selectedWeatherInfo.mainInfo.temperature))")),
				("humidity_title".localized, String(format: "humidity_percentage".localized, "\(Int(selectedWeatherInfo.mainInfo.humidity))")),
				("chances_of_rain_title".localized, String(format: "chances_of_rain".localized, "\(Int(selectedWeatherInfo.cloud.cloudinessPercentage))")),
				("wind_speed_title".localized, String(format: "wind_speed_in_metrics_format".localized, "\(Int(selectedWeatherInfo.wind.speed))"))
		]
	}
	
	var headerItem: DetailWeatherHeaderItem {
		let selectedWeatherInfo = selectedWeatherInfoHandler.selectedWeatherInfo
		return DetailWeatherHeaderItem(locationName: selectedWeatherInfo?.cityName ?? "",
									   weatherInfo: selectedWeatherInfo?.weathers.first?.condition ?? "",
									   iconURL: selectedWeatherInfo?.weathers.first?.iconUrl)
	}
	
	private let selectedWeatherInfoHandler: SelectedWeatherInfoHandling
	
	init(selectedWeatherInfoHandler: SelectedWeatherInfoHandling) {
		self.selectedWeatherInfoHandler = selectedWeatherInfoHandler
	}
}
