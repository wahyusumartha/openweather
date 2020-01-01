//
//  CloudTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class CloudTests: XCTestCase {
	func testInitialisation_shouldCreateAnObject() {
		let percentage: Double = 56
		let cloud = Cloud(cloudinessPercentage: percentage)
		XCTAssertEqual(cloud.cloudinessPercentage, percentage)
	}

	func testInitialisation_shouldCreateAnObject_whenJSONIsValid() {
		let jsonString = #"{"all": 20}"#
		let jsonData = jsonString.data(using: .utf8)!
		let cloud = try! JSONDecoder().decode(Cloud.self, from: jsonData)
		XCTAssertEqual(cloud.cloudinessPercentage, 20)
	}
	
	func testInitialisation_shouldNotCreateAnObject_whenJSONIsNotValid() {
		let jsonString = #"{"alls": 20}"#
		let jsonData = jsonString.data(using: .utf8)!
		let cloud = try? JSONDecoder().decode(Cloud.self, from: jsonData)
		XCTAssertNil(cloud)
	}
}
