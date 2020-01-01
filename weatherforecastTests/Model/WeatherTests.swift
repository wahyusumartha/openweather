//
//  WeatherTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class WeatherTests: XCTestCase {
	func testInitialisation_shouldCreateAnObject() {
		let identifier = 123
		let group = "Clouds"
		let condition = "few clouds"
		let iconId = "02d"
		let weather = Weather(identifier: identifier,
							  group: group,
							  condition: condition,
							  iconId: iconId)
	
		XCTAssertEqual(weather.identifier, identifier)
		XCTAssertEqual(weather.group, group)
		XCTAssertEqual(weather.condition, condition)
		XCTAssertEqual(weather.iconId, iconId)
	}
	
	func testInitialisation_shouldCreateAnObject_whenJSONIsValid() {
		let jsonString = #"{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}"#
		let jsonData = jsonString.data(using: .utf8)!
		let weather = try! JSONDecoder().decode(Weather.self, from: jsonData)
		XCTAssertEqual(weather.identifier, 801)
		XCTAssertEqual(weather.group, "Clouds")
		XCTAssertEqual(weather.condition, "few clouds")
		XCTAssertEqual(weather.iconId, "02d")
	}
	
	func testInitialisation_shouldNotCreateAnObject_whenJSONIsNotValid() {
		let jsonString = #"{"id":801,"mains":"Clouds","description":"few clouds","icon":"02d"}"#
		let jsonData = jsonString.data(using: .utf8)!
		let weather = try? JSONDecoder().decode(Weather.self, from: jsonData)
		XCTAssertNil(weather)
	}
}
