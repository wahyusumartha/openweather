//
//  OpenWeatherRepositoryAssembly.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Swinject

final class OpenWeatherRepositoryAssembly: Assembly {
	
	// MARK: - Public Methods
	func assemble(container: Container) {
		container.register(WeatherRepository.self) { resolver in
			return OpenWeatherRepository(httpClient: resolver.resolve(HTTPClientProtocol.self)!)
		}
	}
}
