//
//  MainInfo.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct MainInfo: Equatable {
	let temperature: Double
	let humidity: Double
}

extension MainInfo: Codable {
	enum CodingKeys: String, CodingKey {
		case temperature = "temp"
		case humidity
	}
}
