//
//  SelectedWeatherInfoHandlerAssembly.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 05.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Swinject

final class SelectedWeatherInfoHandlerAssembly: Assembly {
	
	func assemble(container: Container) {
		container.register(SelectedWeatherInfoHandling.self) { _ in
			SelectedWeatherInfoHandler()
		}.inObjectScope(.container)
	}
}
