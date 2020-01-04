//
//  BookmarkLocationTableViewCellConfigurator.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 03.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Kingfisher
import UIKit

struct BookmarkLocationTableViewCellConfigurator {
	
	func configureCell(_ cell: BookmarkedLocationTableViewCell,
					   with item: BookmarkedLocationViewModel.BookmarkItem) {
		cell.cardView.humidityLabel.text = String(format: "humidity_percentage".localized, "\(item.humidity)")
		cell.cardView.temperatureLabel.text = String(format: "temperature_in_metrics_format".localized, "\(item.temperature)")
		cell.cardView.locationNameLabel.text = "\(item.locationName)"
		cell.cardView.windSpeedLabel.text = String(format: "wind_speed_in_metrics_format".localized, "\(item.windSpeed)")
		cell.cardView.weatherIconImageView.kf.setImage(with: item.iconUrl)
		let radians = CGFloat(item.windDegree * Double.pi / 180)
		cell.cardView.windDirectionImageView.transform = CGAffineTransform(rotationAngle: radians)
	}
	
}
