//
//  OpenWeatherRepositoryTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class OpenWeatherRepositoryTests: XCTestCase {

	private var httpClientMock: HTTPClientMock!
	private var openWeatherRepository: OpenWeatherRepository!
	
    override func setUp() {
		super.setUp()
		
		httpClientMock = HTTPClientMock()
		openWeatherRepository = OpenWeatherRepository(httpClient: httpClientMock)
	}

    override func tearDown() {
		super.tearDown()
		httpClientMock = nil
		openWeatherRepository = nil
	}

	func testWeatherForecastByGeographicCoordinate_shouldHaveError_whenFailedToRetrieveData() {
		let error = HTTPClientError.unknownError(message: nil)
		httpClientMock.getResult = .failure(error)
		
		openWeatherRepository.weatherForecastByGeographicCoordinates(latitude: 0, longitude: 0) { (result) in
			let expectedError: WeatherRepositoryError = .unknownError(message: error.localizedDescription)
			let expectedResult: Result<AggregatedWeatherInfo, WeatherRepositoryError> = .failure(expectedError)
			XCTAssertEqual(result, expectedResult)
		}
	}
	
	func testWeatherForecastByGeographicCoordinate_shouldHaveError_whenFailedToDecodeJSON() {
		let jsonString = #"{"foo": "bar"}"#
		let jsonData = jsonString.data(using: .utf8)!
		httpClientMock.getResult = .success(jsonData)
		
		openWeatherRepository.weatherForecastByGeographicCoordinates(latitude: 0, longitude: 0) { (result) in
			let expectedResult: Result<AggregatedWeatherInfo, WeatherRepositoryError> = .failure(.invalidJSONData)
			XCTAssertEqual(result, expectedResult)
		}
	}
	
	func testWeatherForecastByGeographicCoordinate_shouldBeSuccess_whenSuccessRetrieveDataAndJSONIsValid() {
		let jsonString = #"{"coord":{"lon":0,"lat":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"base":"model","main":{"temp":27.81,"feels_like":31.21,"temp_min":27.81,"temp_max":27.81,"pressure":1011,"humidity":72,"sea_level":1011,"grnd_level":1011},"wind":{"speed":2.07,"deg":228},"clouds":{"all":20},"dt":1577881591,"sys":{"sunrise":1577858370,"sunset":1577902003},"timezone":0,"id":6295630,"name":"Earth","cod":200}"#
		let jsonData = jsonString.data(using: .utf8)!
		httpClientMock.getResult = .success(jsonData)
		
		openWeatherRepository.weatherForecastByGeographicCoordinates(latitude: 0, longitude: 0) { (result) in
			let expectedAggregatedWeatherInfo = try! JSONDecoder().decode(AggregatedWeatherInfo.self, from: jsonData)
			let expectedResult: Result<AggregatedWeatherInfo, WeatherRepositoryError> = .success(expectedAggregatedWeatherInfo)
			
			XCTAssertEqual(result, expectedResult)
		}
	}
}
