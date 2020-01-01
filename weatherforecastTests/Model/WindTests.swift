//
//  WindTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class WindTests: XCTestCase {
	
	func testInitialisation_shouldCreateAnObject() {
		let wind = Wind(speed: 10, degree: 256)
		XCTAssertEqual(wind.speed, 10)
		XCTAssertEqual(wind.degree, 256)
	}

	func testInitialisation_shouldCreateAnObject_whenJSONIsValid() {
		let jsonString = #"{"speed":2.07,"deg":228}"#
		let jsonData = jsonString.data(using: .utf8)!
		let wind = try! JSONDecoder().decode(Wind.self, from: jsonData)
		
		XCTAssertEqual(wind.speed, 2.07)
		XCTAssertEqual(wind.degree, 228)
	}
	
	func testInitialisation_shouldNotCreateAnObject_whenJSONIsNotValid() {
		let jsonString = #"{"speeds":2.07,"deg":228}"#
		let jsonData = jsonString.data(using: .utf8)!
		let wind = try? JSONDecoder().decode(Wind.self, from: jsonData)
		XCTAssertNil(wind)
	}
}
