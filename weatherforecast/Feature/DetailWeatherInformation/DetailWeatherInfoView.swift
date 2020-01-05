//
//  DetailWeatherInfoView.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 05.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

final class DetailWeatherInfoView: UIView {

	let dateLabel: UILabel = {
		let dateLabel = UILabel()
		dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		dateLabel.textColor = .white
		return dateLabel
	}()

	let temperatureHeaderLabel: UILabel = {
		let temperatureHeaderLabel = UILabel()
		temperatureHeaderLabel.text = "temperature_title".localized
		temperatureHeaderLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		temperatureHeaderLabel.textColor = .white
		return temperatureHeaderLabel
	}()
	
	let temperatureLabel: UILabel = {
		let temperatureLabel = UILabel()
		temperatureLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		temperatureLabel.textColor = .white
		return temperatureLabel
	}()
	
	let humidityHeaderLabel: UILabel = {
		let humidityHeaderLabel = UILabel()
		humidityHeaderLabel.text = "humidity_title".localized
		humidityHeaderLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		humidityHeaderLabel.textColor = .white
		return humidityHeaderLabel
	}()
	
	let humidityLabel: UILabel = {
		let humidityLabel = UILabel()
		humidityLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		humidityLabel.textColor = .white
		return humidityLabel
	}()
	
	let rainChancesHeaderLabel: UILabel = {
		let rainChancesHeaderLabel = UILabel()
		rainChancesHeaderLabel.text = "chances_of_rain_title".localized
		rainChancesHeaderLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		rainChancesHeaderLabel.textColor = .white
		return rainChancesHeaderLabel
	}()
	
	let rainChancesLabel: UILabel = {
		let rainChancesLabel = UILabel()
		rainChancesLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		rainChancesLabel.textColor = .white
		return rainChancesLabel
	}()
	
	let windSpeedHeaderLabel: UILabel = {
		let windSpeedHeaderLabel = UILabel()
		windSpeedHeaderLabel.text = "wind_speed_title".localized
		windSpeedHeaderLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		windSpeedHeaderLabel.textColor = .white
		return windSpeedHeaderLabel
	}()
	
	let windSpeedLabel: UILabel = {
		let windSpeedLabel = UILabel()
		windSpeedLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		windSpeedLabel.textColor = .white
		return windSpeedLabel
	}()
	
	private let verticalStackView: UIStackView = {
		let verticalStackView = UIStackView()
		verticalStackView.translatesAutoresizingMaskIntoConstraints = false
		verticalStackView.alignment = .top
		verticalStackView.axis = .vertical
		verticalStackView.distribution = .fillProportionally
		return verticalStackView
	}()
	
	private let horizontalStackView: UIStackView = {
		let horizontalStackView = UIStackView()
		horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
		horizontalStackView.alignment = .center
		horizontalStackView.axis = .horizontal
		horizontalStackView.distribution = .fillEqually
		return horizontalStackView

	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	
		setupSubviews()
	}
	
	private func setupSubviews() {
		backgroundColor = .positiveGreen900
		layer.cornerRadius = 4
		verticalStackView.addArrangedSubview(dateLabel)
		
		let temperatureStackView = createWeatherInfoStackView(headerLabel: temperatureHeaderLabel,
															  valueLabel: temperatureLabel)
		let humidityStackView = createWeatherInfoStackView(headerLabel: humidityHeaderLabel,
														   valueLabel: humidityLabel)
		let rainChancesStackView = createWeatherInfoStackView(headerLabel: rainChancesHeaderLabel,
															  valueLabel: rainChancesLabel)
		let windStackView = createWeatherInfoStackView(headerLabel: windSpeedHeaderLabel,
													   valueLabel: windSpeedLabel)
		horizontalStackView.addArrangedSubview(temperatureStackView)
		horizontalStackView.addArrangedSubview(humidityStackView)
		horizontalStackView.addArrangedSubview(rainChancesStackView)
		horizontalStackView.addArrangedSubview(windStackView)
		addSubview(horizontalStackView)
	
		
		verticalStackView.addArrangedSubview(horizontalStackView)
		addSubview(verticalStackView)
	}
	
	private func createWeatherInfoStackView(headerLabel: UILabel, valueLabel: UILabel) -> UIStackView {
		let stackView = UIStackView()
		stackView.alignment = .center
		stackView.distribution = .fillEqually
		stackView.axis = .vertical

		stackView.addArrangedSubview(headerLabel)
		stackView.addArrangedSubview(valueLabel)
		
		return stackView
	}

}
