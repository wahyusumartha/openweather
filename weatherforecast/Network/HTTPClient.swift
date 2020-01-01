//
//  HTTPClient.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
				  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}


extension URLSession: URLSessionProtocol { }

enum HTTPClientError: Error, Equatable {
	case unknownError(message: String?)
	case emptyData
}

protocol HTTPClientProtocol {
	func get(url: URL, then completionHandler: @escaping (Result<Data, HTTPClientError>) -> Void)
}

struct HTTPClient: HTTPClientProtocol {
	// MARK: - Public Static Properties
	static let cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData

	// MARK: - Private Static Properties
	private static let timeoutInterval: TimeInterval = 10

	// MARK: - Private Properties
	private let session: URLSessionProtocol

	// MARK: - Constructor
	init(session: URLSessionProtocol = URLSession.shared) {
		self.session = session
	}

	// MARK: - Public Methods
	func get(url: URL, then completionHandler: @escaping (Result<Data, HTTPClientError>) -> Void) {
		let urlRequest = Self.makeURLRequest(from: url)
		let task = session.dataTask(with: urlRequest) { (data, _, error) in
			guard error == nil else {
				let error = HTTPClientError.unknownError(message: error?.localizedDescription)
				completionHandler(.failure(error))
				return
			}

			guard let data = data else {
				let emptyDataError = HTTPClientError.emptyData
				completionHandler(.failure(emptyDataError))
				return
			}
				
			completionHandler(.success(data))
		}
		
		task.resume()
	}

	// MARK: - Private Static Methods
	private static func makeURLRequest(from url: URL) -> URLRequest {
		 URLRequest(url: url,
					cachePolicy: Self.cachePolicy,
					timeoutInterval: Self.timeoutInterval)
	}
}
