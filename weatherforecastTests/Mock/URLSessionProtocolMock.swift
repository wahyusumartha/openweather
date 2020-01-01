//
//  URLSessionProtocolMock.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
@testable import weatherforecast

final class URLSessionProtocolMock: URLSessionProtocol {
	var completionHandlerMock: (Data?, URLResponse?, Error?)?
	
	func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		completionHandler(completionHandlerMock?.0, completionHandlerMock?.1, completionHandlerMock?.2)
		return URLSessionDataTask()
	}
}
