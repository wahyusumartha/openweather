//
//  AggregatedWeatherInfoList.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct AggregatedWeatherInfoList: Equatable {
	let infos: [AggregatedWeatherInfo]
}

extension AggregatedWeatherInfoList: Codable {
	enum CodingKeys: String, CodingKey {
		case infos = "list"
	}
}
