//
//  AppDependencyContainer.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 05.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Swinject

final class AppDependencyContainer {
	
	static let shared = AppDependencyContainer()
	
	let assembler: Assembler
	
	init() {
		self.assembler = Assembler([
			HTTPClientAssembly(),
			OpenWeatherRepositoryAssembly(),
			CoreDataPersistenContainerAssembly(),
			LocalBookmarkRepositoryAssembly(),
			SelectedWeatherInfoHandlerAssembly()
		])
	}
}
