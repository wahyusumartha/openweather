//
//  PlaceInfoTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class PlaceInfoTests: XCTestCase {
	
	func testInitialisation_shouldCreateAnObject() {
		let placeInfo = PlaceInfo(identifier: 12345, name: "Hamburg")
		
		XCTAssertEqual(placeInfo.identifier, 12345)
		XCTAssertEqual(placeInfo.name, "Hamburg")
	}
	
	func testInitialisation_shouldCreateAnObject_whenJSONIsValid() {
		let jsonString = #"{"id": 12345, "name": "San Francisco"}"#
		let jsonData = jsonString.data(using: .utf8)!
		let placeInfo = try! JSONDecoder().decode(PlaceInfo.self, from: jsonData)
		
		XCTAssertEqual(placeInfo.identifier, 12345)
		XCTAssertEqual(placeInfo.name, "San Francisco")
	}
	
	func testInitialisation_shouldNotCreateAnObject_whenJSONIsNotValid() {
		let jsonString = #"{"id": 12345, "names": "San Francisco"}"#
		let jsonData = jsonString.data(using: .utf8)!
		let placeInfo = try? JSONDecoder().decode(PlaceInfo.self, from: jsonData)
		XCTAssertNil(placeInfo)
	}

}
