//
//  HTTPClientMock.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//
import Foundation
@testable import weatherforecast

final class HTTPClientMock: HTTPClientProtocol {
	
	var getResult: Result<Data, HTTPClientError>?
	
	func get(url: URL, then completionHandler: @escaping (Result<Data, HTTPClientError>) -> Void) {
		guard let getResult = getResult else {
			return
		}
		
		completionHandler(getResult)
	}
}
