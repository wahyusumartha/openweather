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
	
	var url: URL {
		switch self {
		case .weatherForecastByGeographicCoordinate(let latitude, let longitude):
			let urlAsString = #"\#(OpenWeatherUrlConfiguration.apiUrl)/weather"# +
							  #"?lat=\#(latitude)&lon=\#(longitude)&appid=\#(OpenWeatherCredential.appKey)"#
			guard let url = URL(string: urlAsString) else {
				fatalError("Could not form url for .weatherForecastByGeographicCoordinate")
			}
			
			return url
		}
	}
}
