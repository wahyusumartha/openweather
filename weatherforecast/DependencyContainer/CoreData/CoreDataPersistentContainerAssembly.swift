//
//  CoreDataPersistentContainerAssembly.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Swinject

final class CoreDataPersistenContainerAssembly: Assembly {
	func assemble(container: Container) {
		container.register(CoreDataPersistenContainerHandling.self) { _ in
			return CoreDataPersistenContainerHandler()
		}.inObjectScope(.container)
	}
}
