//
//  DetailWeatherInfoTableViewCellConfigurator.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 05.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation

struct DetailWeatherInfoTableViewCellConfigurator {
	func configureCell(_ cell: DetailWeatherInfoTableViewCell,
					   item: DetailWeatherInfoViewModel.WeatherForecastItem) {
		cell.cardView.temperatureLabel.text = item.temperature
		cell.cardView.humidityLabel.text = item.humidity
		cell.cardView.rainChancesLabel.text = item.humidity
		cell.cardView.windSpeedLabel.text = item.windSpeed
		cell.cardView.dateLabel.text = item.dateAsString
	}
}
