//
//  BookmarkLocationTableViewCellConfigurator.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 03.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct BookmarkLocationTableViewCellConfigurator {
	
	func configureCell(_ cell: BookmarkedLocationTableViewCell,
					   with item: BookmarkedLocationViewModel.BookmarkItem) {
		cell.cardView.humidityLabel.text = "\(item.humidity)"
		cell.cardView.temperatureLabel.text = "\(item.temperature)"
		cell.cardView.locationNameLabel.text = "\(item.locationName)"
		cell.cardView.windSpeedLabel.text = "\(item.windSpeed)"
	}
	
}
