//
//  HTTPClientTests.swift
//  weatherforecastTests
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import XCTest
@testable import weatherforecast

final class HTTPClientTests: XCTestCase {

	private var httpClient: HTTPClient!
	private var urlSessionMock: URLSessionProtocolMock!
	
    override func setUp() {
		super.setUp()
		self.urlSessionMock = URLSessionProtocolMock()
		self.httpClient = HTTPClient(session: urlSessionMock)
	}

    override func tearDown() {
		super.tearDown()
		urlSessionMock = nil
		httpClient = nil
	}

	func testGet_shouldBeFailed_whenErrorIsNotNil() {
		let error = NSError(domain: "Unknown Error", code: 401, userInfo: nil)
		urlSessionMock.completionHandlerMock = (nil, nil, error)
	
		httpClient.get(url: URL(string: "https://google.com")!) { (result) in
			let expectedResult: Result<Data, HTTPClientError> = .failure(HTTPClientError.unknownError(message: error.localizedDescription))
			XCTAssertEqual(result, expectedResult)
		}
	}

	func testGet_shouldBeFailed_whenDataIsNil() {
		urlSessionMock.completionHandlerMock = (nil, nil, nil)
	
		httpClient.get(url: URL(string: "https://google.com")!) { (result) in
			let error = HTTPClientError.emptyData
			let expectedResult: Result<Data, HTTPClientError> = .failure(error)
			XCTAssertEqual(result, expectedResult)
		}
	}
	
	func testGet_shouldBeSuccess_whenDataIsNotNil() {
		let data = "Test response".data(using: .utf8)
		urlSessionMock.completionHandlerMock = (data, nil, nil)
		
		httpClient.get(url: URL(string: "https://google.com")!) { (result) in
			let expectedResult: Result<Data, HTTPClientError> = .success(data!)
			XCTAssertEqual(result, expectedResult)
		}
	}
}
