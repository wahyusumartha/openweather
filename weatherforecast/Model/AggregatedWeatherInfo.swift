//
//  AggregatedWeatherInfo.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct AggregatedWeatherInfo: Equatable {
	let weathers: [Weather]
	let cloud: Cloud
	let wind: Wind
	let mainInfo: MainInfo
	let cityId: Int
	let cityName: String
}

extension AggregatedWeatherInfo: Codable {
	enum CodingKeys: String, CodingKey {
		case weathers = "weather"
		case mainInfo = "main"
		case cloud = "clouds"
		case wind
		case cityId = "id"
		case cityName = "name"
	}
}
