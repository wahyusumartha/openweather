//
//  PlaceInfo.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct PlaceInfo: Equatable {
	let identifier: Int
	let name: String
}

extension PlaceInfo: Codable {
	enum CodingKeys: String, CodingKey {
		case identifier = "id"
		case name
	}
}
