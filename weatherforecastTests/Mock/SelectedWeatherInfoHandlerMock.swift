//
//  SelectedWeatherInfoHandlerMock.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 05.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
@testable import weatherforecast

final class SelectedWeatherInfoHandlerMock: SelectedWeatherInfoHandling {
	
	private(set) var selectedWeatherInfo: AggregatedWeatherInfo?
	
	func updateSelectedWeatherInfo(_ selectedWeatherInfo: AggregatedWeatherInfo) {
		self.selectedWeatherInfo = selectedWeatherInfo
	}
}
