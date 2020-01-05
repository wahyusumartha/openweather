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

	static func makeAddLocationViewController() -> AddLocationViewController {
		let deviceLocationHandler = DeviceLocationHandler()
		let assembler = AppDependencyContainer.shared.assembler
		let openWeatherRepository = assembler.resolver.resolve(WeatherRepository.self)!
		let localBookmarkRepository = assembler.resolver.resolve(BookmarkLocationRepository.self)!
		let viewModel = AddLocationViewModel(deviceLocationHandler: deviceLocationHandler,
											 weatherRepository: openWeatherRepository,
											 localBookmarkRepository: localBookmarkRepository)
		return AddLocationViewController(viewModel: viewModel)
	}
}
