//
//  Weather.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct Weather: Equatable {
	let identifier: Int
	let group: String
	let condition: String
	let iconId: String
}

extension Weather: Codable {
	enum CodingKeys: String, CodingKey {
		case identifier = "id"
		case group = "main"
		case condition = "description"
		case iconId = "icon"
	}
}
