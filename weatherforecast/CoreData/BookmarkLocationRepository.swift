//
//  BookmarkLocationRepository.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

protocol BookmarkLocationRepository {
	func saveLocation(_ placeInfo: PlaceInfo, completionHandler: (Result<Void, Error>) -> Void)
	func retrieveAllLocations(completionHandler: (Result<[PlaceInfo], Error>) -> Void)
	func removeLocation(cityId: Int, completionHandler: (Result<Void, Error>) -> Void)
}
