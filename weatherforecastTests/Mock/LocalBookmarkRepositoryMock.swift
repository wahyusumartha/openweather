//
//  LocalBookmarkRepositoryMock.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
@testable import weatherforecast

final class LocalBookmarkRepositoryMock: BookmarkLocationRepository {

	var saveLocationResultMock: Result<Void, Error>?
	var retrieveAllLocationsResultMock: Result<[PlaceInfo], Error>?
	
	func saveLocation(_ placeInfo: PlaceInfo, completionHandler: (Result<Void, Error>) -> Void) {
		guard let saveLocationResultMock = saveLocationResultMock else { return }
		completionHandler(saveLocationResultMock)
	}
	
	func retrieveAllLocations(completionHandler: (Result<[PlaceInfo], Error>) -> Void) {
		guard let retrieveAllLocationsResultMock = retrieveAllLocationsResultMock else { return }
		completionHandler(retrieveAllLocationsResultMock)
	}
}
