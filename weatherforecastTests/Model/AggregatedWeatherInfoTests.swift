//
//  AggregatedWeatherInfoTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class AggregatedWeatherInfoTests: XCTestCase {

	func testInitialisation_shouldCreateAnObject() {
		let weather = Weather(identifier: 120,
							  group: "Cloudy",
							  condition: "few clouds",
							  iconId: "02d")
		let cloud = Cloud(cloudinessPercentage: 80)
		let wind = Wind(speed: 20, degree: 248)
		let mainInfo = MainInfo(temperature: 30, humidity: 50)
		let aggregatedWeatherInfo = AggregatedWeatherInfo(weathers: [weather],
														  cloud: cloud,
														  wind: wind,
														  mainInfo: mainInfo)
		
		XCTAssertEqual(aggregatedWeatherInfo.weathers, [weather])
		XCTAssertEqual(aggregatedWeatherInfo.cloud, cloud)
		XCTAssertEqual(aggregatedWeatherInfo.wind, wind)
		XCTAssertEqual(aggregatedWeatherInfo.mainInfo, mainInfo)
	}
	
	func testInitialisation_shouldCreateAnObject_whenJSONIsValid() {
		let jsonString = #"{"coord":{"lon":0,"lat":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"base":"model","main":{"temp":27.81,"feels_like":31.21,"temp_min":27.81,"temp_max":27.81,"pressure":1011,"humidity":72,"sea_level":1011,"grnd_level":1011},"wind":{"speed":2.07,"deg":228},"clouds":{"all":20},"dt":1577881591,"sys":{"sunrise":1577858370,"sunset":1577902003},"timezone":0,"id":6295630,"name":"Earth","cod":200}"#
		let jsonData = jsonString.data(using: .utf8)!
		let aggregatedWeatherInfo = try! JSONDecoder().decode(AggregatedWeatherInfo.self, from: jsonData)
		
		let expectedWeather = Weather(identifier: 801, group: "Clouds", condition: "few clouds", iconId: "02d")
		let expectedCloud = Cloud(cloudinessPercentage: 20)
		let expectedWind = Wind(speed: 2.07, degree: 228)
		let expectedMainInfo = MainInfo(temperature: 27.81, humidity: 72)
		
		XCTAssertEqual(aggregatedWeatherInfo.weathers, [expectedWeather])
		XCTAssertEqual(aggregatedWeatherInfo.cloud, expectedCloud)
		XCTAssertEqual(aggregatedWeatherInfo.wind, expectedWind)
		XCTAssertEqual(aggregatedWeatherInfo.mainInfo, expectedMainInfo)
	}
	
	func testInitialisation_shouldNotCreateAnObject_whenJSONIsNotValid() {
		let jsonString = #"{"coord":{"lon":0,"lat":0},"weathers":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"base":"model","main":{"temp":27.81,"feels_like":31.21,"temp_min":27.81,"temp_max":27.81,"pressure":1011,"humidity":72,"sea_level":1011,"grnd_level":1011},"wind":{"speed":2.07,"deg":228},"clouds":{"all":20},"dt":1577881591,"sys":{"sunrise":1577858370,"sunset":1577902003},"timezone":0,"id":6295630,"name":"Earth","cod":200}"#
		let jsonData = jsonString.data(using: .utf8)!
		let aggregatedWeatherInfo = try? JSONDecoder().decode(AggregatedWeatherInfo.self, from: jsonData)
		XCTAssertNil(aggregatedWeatherInfo)
	}
}
