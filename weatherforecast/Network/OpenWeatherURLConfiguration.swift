//
//  OpenWeatherURLConfiguration.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

enum OpenWeatherUrlConfiguration {
	static let baseUrl = "https://api.openweathermap.org/data"
	static let apiVersion = "2.5"
	static let apiUrl = Self.baseUrl + "/" + Self.apiVersion
}
