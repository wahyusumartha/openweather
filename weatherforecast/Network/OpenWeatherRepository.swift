//
//  OpenWeatherRepository.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct OpenWeatherRepository: WeatherRepository {

	// MARK: - Private Properties
	private let httpClient: HTTPClientProtocol

	// MARK: - Constructor
	init(httpClient: HTTPClientProtocol) {
		self.httpClient = httpClient
	}

	// MARK: - Public Methods
	func weatherForecastByGeographicCoordinates(latitude: Double,
												longitude: Double,
												completionHandler: @escaping (Result<AggregatedWeatherInfo, WeatherRepositoryError>) -> Void) {
		let endPoint = OpenWeatherEndpoint.weatherForecastByGeographicCoordinate(latitude: latitude,
																				 longitude: longitude)
		httpClient.get(url: endPoint.url) { (result) in
			switch result {
			case .success(let data):
				guard let aggregatedWeatherInfo = try? JSONDecoder().decode(AggregatedWeatherInfo.self, from: data)
				else {
					let error = WeatherRepositoryError.invalidJSONData
					completionHandler(.failure(error))
					return
				}
				
				completionHandler(.success(aggregatedWeatherInfo))
			case .failure(let responseError):
				let error = WeatherRepositoryError.unknownError(message: responseError.localizedDescription)
				completionHandler(.failure(error))
			}
		}
	}

	func retrievePlaceInformation(latitude: Double,
								  longitude: Double,
								  completionHandler: @escaping (Result<PlaceInfo, WeatherRepositoryError>) -> Void) {
		let endPoint = OpenWeatherEndpoint.placeInfo(latitude: latitude,
													 longitude: longitude)
		
		httpClient.get(url: endPoint.url) { (result) in
			switch result {
			case .success(let data):
				guard let placeInfo = try? JSONDecoder().decode(PlaceInfo.self, from: data)
				else {
					let error = WeatherRepositoryError.invalidJSONData
					completionHandler(.failure(error))
					return
				}
				
				completionHandler(.success(placeInfo))
			case .failure(let responseError):
				let error = WeatherRepositoryError.unknownError(message: responseError.localizedDescription)
				completionHandler(.failure(error))
			}
		}
	}
	
	func weatherForecastByCityIds(_ cityIds: [Int],
								  completionHandler: @escaping (Result<AggregatedWeatherInfoList, WeatherRepositoryError>) -> Void) {
		let endPoint = OpenWeatherEndpoint.weatherForecastByCityIds(cityIds)
		
		httpClient.get(url: endPoint.url) { (result) in
			switch result {
				case .success(let data):
					guard let aggregatedWeatherInfoList = try? JSONDecoder().decode(AggregatedWeatherInfoList.self, from: data)
					else {
						let error = WeatherRepositoryError.invalidJSONData
						completionHandler(.failure(error))
						return
					}
					
					completionHandler(.success(aggregatedWeatherInfoList))
				case .failure(let responseError):
					let error = WeatherRepositoryError.unknownError(message: responseError.localizedDescription)
					completionHandler(.failure(error))
			}
		}
	}
	
	func fiveDaysWeatherForecast(cityId: Int,
								 completionHandler: @escaping (Result<AggregatedWeatherInfoList, WeatherRepositoryError>) -> Void) {
		let endPoint = OpenWeatherEndpoint.fiveDaysWeatherForecast(cityId: cityId)
		
		httpClient.get(url: endPoint.url) { (result) in
			switch result {
			case .success(let data):
				guard let aggregatedWeatherInfoList = try? JSONDecoder().decode(AggregatedWeatherInfoList.self, from: data)
				else {
					let error = WeatherRepositoryError.invalidJSONData
					completionHandler(.failure(error))
					return
				}
				
				completionHandler(.success(aggregatedWeatherInfoList))
			case .failure(let responseError):
				let error = WeatherRepositoryError.unknownError(message: responseError.localizedDescription)
				completionHandler(.failure(error))
			}
		}
	}
}
