//
//  OpenWeatherUrlConfigurationTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class OpenWeatherUrlConfigurationTests: XCTestCase {
	func testAPIURL_shouldReturnCombinationOfBaseUrlAndVersion() {
		let expectedAPIUrl = "https://api.openweathermap.org/data/2.5"
		XCTAssertEqual(OpenWeatherUrlConfiguration.apiUrl, expectedAPIUrl)
	}
}
