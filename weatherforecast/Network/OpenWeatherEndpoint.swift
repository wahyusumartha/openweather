//
//  OpenWeatherEndpoint.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

enum OpenWeatherEndpoint {
	case weatherForecastByGeographicCoordinate(latitude: Double, longitude: Double)
	case fiveDaysWeatherForecastByGeographicCoordinate(latitude: Double, longitude: Double)
	case placeInfo(latitude: Double, longitude: Double)
	case weatherForecastByCityIds(_ cityIds: [Int])
	var url: URL {
		switch self {
		case .weatherForecastByGeographicCoordinate(let latitude, let longitude),
			 .placeInfo(let latitude, let longitude):
			let urlAsString = #"\#(OpenWeatherUrlConfiguration.apiUrl)/weather"# +
							  #"?lat=\#(latitude)&lon=\#(longitude)&appid=\#(OpenWeatherCredential.appKey)&units=metric"#
			guard let url = URL(string: urlAsString) else {
				fatalError("Could not form url for .weatherForecastByGeographicCoordinate or .placeInfo")
			}
			
			return url
		case .weatherForecastByCityIds(let cityIds):
			let cityIdsAsString = cityIds.map { String($0) }.joined(separator: ",")
			let urlAsString = #"\#(OpenWeatherUrlConfiguration.apiUrl)/group"# +
							  #"?id=\#(cityIdsAsString)&appid=\#(OpenWeatherCredential.appKey)&units=metric"#
			
			guard let url = URL(string: urlAsString) else {
				fatalError("Could not form url for .weatherForecastByCityIds")
			}
			
			return url
		case .fiveDaysWeatherForecastByGeographicCoordinate(let latitude, let longitude):
			let urlAsString = #"\#(OpenWeatherUrlConfiguration.apiUrl)/forecast"# +
							  #"?lat=\#(latitude)&lon=\#(longitude)&appid=\#(OpenWeatherCredential.appKey)&units=metric"#
			guard let url = URL(string: urlAsString) else {
				fatalError("Could not form url for .weatherForecastByGeographicCoordinate or .placeInfo")
			}
			
			return url
		}
	}
}
