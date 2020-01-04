//
//  BookmarkedLocationViewModelTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class BookmarkedLocationViewModelTests: XCTestCase {
	
	private var viewModel: BookmarkedLocationViewModel!
	private var openWeatherRepositoryMock: OpenWeatherRepositoryMock!
	private var localBookmarkRepositoryMock: LocalBookmarkRepositoryMock!
	
	
    override func setUp() {
		super.setUp()
		
		openWeatherRepositoryMock = OpenWeatherRepositoryMock()
		localBookmarkRepositoryMock = LocalBookmarkRepositoryMock()
		viewModel = BookmarkedLocationViewModel(localBookmarkRepository: localBookmarkRepositoryMock,
												openWeatherRepository: openWeatherRepositoryMock)
	}

    override func tearDown() {
		super.tearDown()
		openWeatherRepositoryMock = nil
		localBookmarkRepositoryMock = nil
		viewModel = nil
	}

	func testRetrieveBookmarkLocation_shouldReturnBookmarkItems_whenRequestSucceed() {
		let placeInfos = [
			PlaceInfo(identifier: 1234, name: "Hamburg"),
			PlaceInfo(identifier: 1235, name: "Amsterdam")
		]
		localBookmarkRepositoryMock.retrieveAllLocationsResultMock = .success(placeInfos)
		
		let cloud = Cloud(cloudinessPercentage: 80)
		let wind = Wind(speed: 20, degree: 248)
		let mainInfo = MainInfo(temperature: 30, humidity: 50)
		let cityId = 12345
		let cityName = "Hamburg"
		let aggregatedWeatherInfo = AggregatedWeatherInfo(weathers: [],
														  cloud: cloud,
														  wind: wind,
														  mainInfo: mainInfo,
														  cityId: cityId,
														  cityName: cityName)
		let infoList = AggregatedWeatherInfoList(infos: [aggregatedWeatherInfo, aggregatedWeatherInfo])
		openWeatherRepositoryMock.weatherForecastByCitiIdsResultMock = .success(infoList)
		
		viewModel.retrieveBookmarkedLocations()
		
		XCTAssertEqual(viewModel.items.value.count, infoList.infos.count)
		XCTAssertEqual(viewModel.numberOfRows, infoList.infos.count)
	}

	func testRetrieveBookmarkLocation_shouldShowErrorMessage_whenRequestFailed() {
		let error = NSError(domain: "Unknown", code: 500, userInfo: nil)
		localBookmarkRepositoryMock.retrieveAllLocationsResultMock = .failure(error)
		openWeatherRepositoryMock.weatherForecastByCitiIdsResultMock = .failure(.invalidJSONData)
	
		let navigationDelegateMock = BookmarkedLocationViewControllerNavigationDelegateMock()
		viewModel.navigationDelegate = navigationDelegateMock
		
		viewModel.retrieveBookmarkedLocations()

		XCTAssertTrue(navigationDelegateMock.didShowErrorMessage)
	}
	
	func testShowAddLocation_shouldInvokeNavigationDelegate() {
		let navigationDelegateMock = BookmarkedLocationViewControllerNavigationDelegateMock()
		viewModel.navigationDelegate = navigationDelegateMock
		
		viewModel.showAddLocation()
		
		XCTAssertTrue(navigationDelegateMock.didShowAddLocation)
	}
}

final class BookmarkedLocationViewControllerNavigationDelegateMock: BookmarkedLocationViewControllerNavigationDelegate {
	
	private (set) var didShowErrorMessage = false
	private (set) var didShowAddLocation = false
	private (set) var didShowDetailWeatherInfo = false
	
	func showErrorMessage(_ message: String?) {
		didShowErrorMessage = true
	}
	
	func showAddLocation() {
		didShowAddLocation = true
	}
	
	func showDetailWeatherInfo() {
		didShowDetailWeatherInfo = true
	}
}
