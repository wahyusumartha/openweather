//
//  DetailWeatherInfoFactory.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Swinject

final class DetailWeatherInfoFactory {
	static func makeDetailWeatherInfoViewController() -> DetailWeatherInfoViewController {
		let assembler = AppDependencyContainer.shared.assembler
		let selectedWeatherInfoHandler = assembler.resolver.resolve(SelectedWeatherInfoHandling.self)!
		let viewModel = DetailWeatherInfoViewModel(selectedWeatherInfoHandler: selectedWeatherInfoHandler)
		return DetailWeatherInfoViewController(viewModel: viewModel)
	}
}
