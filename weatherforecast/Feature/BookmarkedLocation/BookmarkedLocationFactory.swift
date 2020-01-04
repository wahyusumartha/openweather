//
//  BookmarkedLocationFactory.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Swinject

struct BookmarkedLocationFactory {

	private let assembler: Assembler
	
	init(assembler: Assembler = Assembler([CoreDataPersistenContainerAssembly(),
										   LocalBookmarkRepositoryAssembly(),
										   HTTPClientAssembly(),
										   OpenWeatherRepositoryAssembly()])) {
		self.assembler = assembler
	}
	
	
	func makeBookmarkedLocationViewController() -> BookmarkedLocationViewController {
		let localBookmarkRepository = assembler.resolver.resolve(BookmarkLocationRepository.self)!
		let openWeatherRepository = assembler.resolver.resolve(WeatherRepository.self)!
		let viewModel = BookmarkedLocationViewModel(localBookmarkRepository: localBookmarkRepository,
													openWeatherRepository: openWeatherRepository)
		let bookmarkedLocationViewController = BookmarkedLocationViewController(viewModel: viewModel)
		return bookmarkedLocationViewController
	}
}
