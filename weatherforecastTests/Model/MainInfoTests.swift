//
//  MainInfoTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class MainInfoTests: XCTestCase {
	
	func testInitialisation_shouldCreateAnObject() {
		let mainInfo = MainInfo(temperature: 20, humidity: 50)
		XCTAssertEqual(mainInfo.temperature, 20)
		XCTAssertEqual(mainInfo.humidity, 50)
	}
	
	func testInitialisation_shouldCreateAnObject_whenJSONIsValid() {
		let jsonString = #"{"temp":27.81,"feels_like":31.21,"temp_min":27.81,"temp_max":27.81,"pressure":1011,"humidity":72,"sea_level":1011,"grnd_level":1011}"#
		let jsonData = jsonString.data(using: .utf8)!
		let mainInfo = try! JSONDecoder().decode(MainInfo.self, from: jsonData)
		XCTAssertEqual(mainInfo.temperature, 27.81)
		XCTAssertEqual(mainInfo.humidity, 72)
	}
	
	func testInitialisation_shouldNotCreateAnObject_whenJSONIsNotValid() {
		let jsonString = #"{"temp":27.81,"feels_like":31.21,"temp_min":27.81,"temp_max":27.81,"pressure":1011,"humidities":72,"sea_level":1011,"grnd_level":1011}"#
		let jsonData = jsonString.data(using: .utf8)!
		let mainInfo = try? JSONDecoder().decode(MainInfo.self, from: jsonData)
		XCTAssertNil(mainInfo)
	}
}
