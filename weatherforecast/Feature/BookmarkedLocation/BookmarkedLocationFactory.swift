//
//  BookmarkedLocationFactory.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct BookmarkedLocationFactory {
	static func makeBookmarkedLocationViewController() -> BookmarkedLocationViewController {
		let bookmarkedLocationViewController = BookmarkedLocationViewController()
		return bookmarkedLocationViewController
	}
}
