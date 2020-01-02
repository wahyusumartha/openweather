//
//  LocalBookmarkRepositoryAssembly.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Swinject

final class LocalBookmarkRepositoryAssembly: Assembly {
	func assemble(container: Container) {
		container.register(BookmarkLocationRepository.self) { resolver in
			let persistentContainerHandler = resolver.resolve(CoreDataPersistenContainerHandling.self)!
			return LocalBookmarkRepository(persistentContainerHandler: persistentContainerHandler)
		}
	}
}
