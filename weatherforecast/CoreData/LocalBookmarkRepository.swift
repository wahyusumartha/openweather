//
//  LocalBookmarkRepository.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import CoreData

enum LocalBookmarkRepositoryError: Error {
	case duplicateData
	case entityNotFound
}

struct LocalBookmarkRepository: BookmarkLocationRepository {

	private static let locationEntityName = "Location"
	private static let cityIdKey = "cityId"
	private static let cityNameKey = "cityName"
	
	private let persistentContainerHandler: CoreDataPersistenContainerHandling
	
	init(persistentContainerHandler: CoreDataPersistenContainerHandling) {
		self.persistentContainerHandler = persistentContainerHandler
	}
	
	func saveLocation(_ placeInfo: PlaceInfo, completionHandler: (Result<Void, Error>) -> Void) {
		let managedContext = persistentContainerHandler.persistentContainer.viewContext
		
		guard let entity = NSEntityDescription.entity(forEntityName: Self.locationEntityName,
													  in: managedContext)
		else {
			completionHandler(.failure(LocalBookmarkRepositoryError.entityNotFound))
			return
		}
		
		
		do {
			let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Self.locationEntityName)
			let locations = try managedContext.fetch(fetchRequest)
			let foundLocation = locations.filter { ($0.value(forKey: Self.cityIdKey) as? Int) == placeInfo.identifier }.first
			
			guard foundLocation == nil else {
				completionHandler(.failure(LocalBookmarkRepositoryError.duplicateData))
				return
			}
		
			let location = NSManagedObject(entity: entity, insertInto: managedContext)
			
			location.setValue(placeInfo.identifier, forKey: Self.cityIdKey)
			location.setValue(placeInfo.name, forKey: Self.cityNameKey)
			
			try managedContext.save()
			completionHandler(.success(()))
		} catch let error {
			completionHandler(.failure(error))
		}
	}
	
	func retrieveAllLocations(completionHandler: (Result<[PlaceInfo], Error>) -> Void) {
		let managedContext = persistentContainerHandler.persistentContainer.viewContext
		
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Self.locationEntityName)
		
		do {
			let locations = try managedContext.fetch(fetchRequest)
			var placeInfos: [PlaceInfo] = []
			let reversedLocation = locations.reversed()
			reversedLocation.forEach {
				if let identifier = $0.value(forKey: Self.cityIdKey) as? Int,
					let name = $0.value(forKey: Self.cityNameKey) as? String {
					let placeInfo = PlaceInfo(identifier: identifier, name: name)
					placeInfos.append(placeInfo)
				}
			}
			completionHandler(.success(placeInfos))
		} catch let error {
			completionHandler(.failure(error))
		}
	}
	
	func removeLocation(cityId: Int, completionHandler: (Result<Void, Error>) -> Void) {
		let managedContext = persistentContainerHandler.persistentContainer.viewContext
		
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Self.locationEntityName)
		
		do {
			let locations = try managedContext.fetch(fetchRequest)
			let foundLocation = locations.filter { ($0.value(forKey: Self.cityIdKey) as? Int) == cityId }.first
			guard let locationToBeDeleted = foundLocation else {
				completionHandler(.failure(LocalBookmarkRepositoryError.entityNotFound))
				return
			}
			
			managedContext.delete(locationToBeDeleted)
			try managedContext.save()
			completionHandler(.success(()))
		} catch let error {
			completionHandler(.failure(error))
		}
	}
}
