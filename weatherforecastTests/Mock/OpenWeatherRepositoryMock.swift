//
//  OpenWeatherRepositoryMock.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
@testable import weatherforecast

final class OpenWeatherRepositoryMock: WeatherRepository {

	var weatherForecastByCitiIdsResultMock: Result<AggregatedWeatherInfoList, WeatherRepositoryError>?
		
	func weatherForecastByCityIds(_ cityIds: [Int],
								  completionHandler: @escaping (Result<AggregatedWeatherInfoList, WeatherRepositoryError>) -> Void) {
		guard let weatherForecastByCitiIdsResultMock = weatherForecastByCitiIdsResultMock else { return }
		completionHandler(weatherForecastByCitiIdsResultMock)
	}
	
	func weatherForecastByGeographicCoordinates(latitude: Double,
												longitude: Double,
												completionHandler: @escaping (Result<AggregatedWeatherInfo, WeatherRepositoryError>) -> Void) {
		
	}
	
	func retrievePlaceInformation(latitude: Double,
								  longitude: Double,
								  completionHandler: @escaping (Result<PlaceInfo, WeatherRepositoryError>) -> Void) {
		
	}
	
}
