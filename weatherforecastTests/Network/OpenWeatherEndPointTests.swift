//
//  OpenWeatherEndPointTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class OpenWeatherEndPointTests: XCTestCase {
	func testWeatherForecastByGeographicCoordinateURL_shouldReturnCorrectUrl() {
		let latitude: Double = 53.551086
		let longitude: Double = 9.993682
		let appId = OpenWeatherCredential.appKey
		let urlAsString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(appId)"
		let expectedUrl = URL(string: urlAsString)!
		let endpoint = OpenWeatherEndpoint.weatherForecastByGeographicCoordinate(latitude: latitude,
																				 longitude: longitude)
		XCTAssertEqual(endpoint.url, expectedUrl)
	}
}
