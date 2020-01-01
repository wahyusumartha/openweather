//
//  HTTPClientAssembly.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import Swinject

final class HTTPClientAssembly: Assembly {
		
	// MARK: - Public Methods
	func assemble(container: Container) {
		container.register(HTTPClientProtocol.self) { _ in
			return HTTPClient()
		}
	}
}
