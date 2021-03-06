//
//  Cloud.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct Cloud: Equatable {
	let cloudinessPercentage: Double
}

extension Cloud: Codable {
	enum CodingKeys: String, CodingKey {
		case cloudinessPercentage = "all"
	}
}
