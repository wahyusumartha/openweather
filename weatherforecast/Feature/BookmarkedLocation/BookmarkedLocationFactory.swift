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

	static func makeBookmarkedLocationViewController() -> BookmarkedLocationViewController {
		let assembler = AppDependencyContainer.shared.assembler
		let localBookmarkRepository = assembler.resolver.resolve(BookmarkLocationRepository.self)!
		let openWeatherRepository = assembler.resolver.resolve(WeatherRepository.self)!
		let selectedWeatherInfoHandler = assembler.resolver.resolve(SelectedWeatherInfoHandling.self)!
		let viewModel = BookmarkedLocationViewModel(localBookmarkRepository: localBookmarkRepository,
													openWeatherRepository: openWeatherRepository,
													selectedWeatherInfoHandler: selectedWeatherInfoHandler)
		let bookmarkedLocationViewController = BookmarkedLocationViewController(viewModel: viewModel)
		return bookmarkedLocationViewController
	}
}
