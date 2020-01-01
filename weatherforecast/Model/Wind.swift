//
//  Wind.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct Wind: Equatable {
	let speed: Double
	let degree: Double
}

extension Wind: Codable {
	enum CodingKeys: String, CodingKey {
		case speed
		case degree = "deg"
	}
}
