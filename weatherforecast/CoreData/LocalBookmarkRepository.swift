//
//  LocalBookmarkRepository.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import CoreData

struct LocalBookmarkRepository: BookmarkLocationRepository {

	private static let locationEntityName = "Location"
	private static let countryIdKey = "countryId"
	private static let countryNameKey = "countryName"
	
	private let persistentContainerHandler: CoreDataPersistenContainerHandling
	
	init(persistentContainerHandler: CoreDataPersistenContainerHandling) {
		self.persistentContainerHandler = persistentContainerHandler
	}
	
	func saveLocation(_ placeInfo: PlaceInfo, completionHandler: (Result<Void, Error>) -> Void) {
		let managedContext = persistentContainerHandler.persistentContainer.viewContext
		
		guard let entity = NSEntityDescription.entity(forEntityName: Self.locationEntityName,
													  in: managedContext)
		else {
			return
		}
		
		let location = NSManagedObject(entity: entity, insertInto: managedContext)
		
		location.setValue(placeInfo.identifier, forKey: Self.countryIdKey)
		location.setValue(placeInfo.name, forKey: Self.countryNameKey)
		
		do {
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
			locations.forEach {
				if let identifier = $0.value(forKey: Self.countryIdKey) as? Int,
					let name = $0.value(forKey: Self.countryNameKey) as? String {
					let placeInfo = PlaceInfo(identifier: identifier, name: name)
					placeInfos.append(placeInfo)
				}
			}
			completionHandler(.success(placeInfos))
		} catch let error {
			completionHandler(.failure(error))
		}
	}
}
