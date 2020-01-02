//
//  CoreDataPersistentContainerHandler.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataPersistenContainerHandling {
	var persistentContainer: NSPersistentContainer { get }
}

final class CoreDataPersistenContainerHandler: CoreDataPersistenContainerHandling {

	private static let persistenContainerName = "BookmarkLocation"
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: Self.persistenContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
	}()
}
