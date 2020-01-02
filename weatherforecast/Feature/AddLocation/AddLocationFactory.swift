//
//  AddLocationFactory.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Swinject

struct AddLocationFactory {

	private let assembler: Assembler
	
	
	init(assembler: Assembler = Assembler([HTTPClientAssembly(),
										   OpenWeatherRepositoryAssembly(),
										   CoreDataPersistenContainerAssembly(),
										   LocalBookmarkRepositoryAssembly()])) {
		self.assembler = assembler
	}
	
	func makeAddLocationViewController() -> AddLocationViewController {
		let deviceLocationHandler = DeviceLocationHandler()
		let openWeatherRepository = assembler.resolver.resolve(WeatherRepository.self)!
		let localBookmarkRepository = assembler.resolver.resolve(BookmarkLocationRepository.self)!
		let viewModel = AddLocationViewModel(deviceLocationHandler: deviceLocationHandler,
											 weatherRepository: openWeatherRepository,
											 localBookmarkRepository: localBookmarkRepository)
		return AddLocationViewController(viewModel: viewModel)
	}
}
