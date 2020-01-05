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
	let cityId: Int?
	let cityName: String?
	let timestamp: TimeInterval?
}

extension AggregatedWeatherInfo: Codable {
	enum CodingKeys: String, CodingKey {
		case weathers = "weather"
		case mainInfo = "main"
		case cloud = "clouds"
		case wind
		case cityId = "id"
		case cityName = "name"
		case timestamp = "dt"
	}
}

extension AggregatedWeatherInfo {
	var formattedDateAsString: String {
		let date = Date(timeIntervalSince1970: timestamp ?? 0)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
		return dateFormatter.string(from: date)
	}
}
