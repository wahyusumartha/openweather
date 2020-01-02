//
//  WeatherRepository.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

enum WeatherRepositoryError: Error, Equatable {
	case invalidJSONData
	case unknownError(message: String?)
}

protocol WeatherRepository {
	func weatherForecastByGeographicCoordinates(latitude: Double,
												longitude: Double,
												completionHandler: @escaping (Result<AggregatedWeatherInfo, WeatherRepositoryError>) -> Void)
	func retrievePlaceInformation(latitude: Double,
								  longitude: Double,
								  completionHandler: @escaping (Result<PlaceInfo, WeatherRepositoryError>) -> Void)
}
