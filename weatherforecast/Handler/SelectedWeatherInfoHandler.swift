//
//  SelectedWeatherInfoHandler.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

protocol SelectedWeatherInfoHandling: class {
	var selectedWeatherInfo: AggregatedWeatherInfo? { get }

	func updateSelectedWeatherInfo(_ selectedWeatherInfo: AggregatedWeatherInfo)
}

final class SelectedWeatherInfoHandler: SelectedWeatherInfoHandling {
	private(set) var selectedWeatherInfo: AggregatedWeatherInfo?
		
	func updateSelectedWeatherInfo(_ selectedWeatherInfo: AggregatedWeatherInfo) {
		self.selectedWeatherInfo = selectedWeatherInfo
	}
	
}
