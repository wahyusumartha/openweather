//
//  BookmarkLocationCardView.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

final class BookmarkLocationCardView: UIView {
	
	// MARK: - Public Properties
	
	let locationNameLabel: UILabel = {
		let locationNameLabel = UILabel()
		locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
		locationNameLabel.textColor = .authenticBlue900
		locationNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		locationNameLabel.text = "Hamburg"
		return locationNameLabel
	}()
	
	let weatherIconImageView: UIImageView = {
		let weatherIconImageView = UIImageView()
		weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
		weatherIconImageView.backgroundColor = .bumpyMagenta1000
		return weatherIconImageView
	}()
		
	let temperatureLabel: UILabel = {
		let temperatureLabel = UILabel()
		temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
		temperatureLabel.textColor = .authenticBlue50
		temperatureLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		temperatureLabel.text = "15°"
		return temperatureLabel
	}()

	let windDirectionImageView: UIImageView = {
		let windDirectionImageView = UIImageView()
		windDirectionImageView.translatesAutoresizingMaskIntoConstraints = false
		windDirectionImageView.image = UIImage(named: "compass-north-icon")
		return windDirectionImageView
	}()

	let windSpeedLabel: UILabel = {
		let windSpeedLabel = UILabel()
		windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
		windSpeedLabel.textColor = .authenticBlue900
		windSpeedLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		windSpeedLabel.text = "50 km/h"
		return windSpeedLabel
	}()

	let humidityLabel: UILabel = {
		let humidityLabel = UILabel()
		humidityLabel.translatesAutoresizingMaskIntoConstraints = false
		humidityLabel.textColor = .authenticBlue900
		humidityLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		humidityLabel.text = "100 %"
		return humidityLabel
	}()
	
	// MARK: - Private Properties
	
	private let humidityIconImageView: UIImageView = {
		let humidityIconImageView = UIImageView()
		humidityIconImageView.translatesAutoresizingMaskIntoConstraints = false
		let image = UIImage(named: "water-icon")
		humidityIconImageView.image = image
		return humidityIconImageView
	}()
	
	private let containerView: UIView = {
		let containerView = UIView()
		containerView.translatesAutoresizingMaskIntoConstraints = false
		containerView.backgroundColor = .positiveGreen900
		containerView.layer.cornerRadius = 4
		return containerView
	}()
	
	// MARK: - Initialiser
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupSubviews()
		setupLeftSubviewsConstraints()
		setupRightSubviewsConstraints()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	// MARK: - Private Methods
	
	private func setupSubviews() {
		backgroundColor = .positiveGreen50
		layer.cornerRadius = 4
		addSubview(locationNameLabel)

		containerView.addSubview(weatherIconImageView)
		containerView.addSubview(temperatureLabel)
		addSubview(containerView)

		addSubview(humidityIconImageView)
		addSubview(humidityLabel)
		addSubview(windSpeedLabel)
		addSubview(windDirectionImageView)
	}
	
	private func setupRightSubviewsConstraints() {
		let locationNameLabelConstraints = [
			locationNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			locationNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
			locationNameLabel.leadingAnchor.constraint(equalTo:  containerView.trailingAnchor, constant: 5)
		]

		let humidityIconImageViewConstraints = [
			humidityIconImageView.leadingAnchor.constraint(equalTo: locationNameLabel.leadingAnchor, constant: -15),
			humidityIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
			humidityIconImageView.heightAnchor.constraint(equalToConstant: 50),
			humidityIconImageView.widthAnchor.constraint(equalToConstant: 50)
		]

		let humidityLabelConstraints = [
			humidityLabel.leadingAnchor.constraint(equalTo: humidityIconImageView.trailingAnchor, constant: -15),
			humidityLabel.centerYAnchor.constraint(equalTo: humidityIconImageView.centerYAnchor)
		]

		let windSpeedLabelConstraints = [
			windSpeedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
			windSpeedLabel.centerYAnchor.constraint(equalTo: humidityLabel.centerYAnchor)
		]

		let windDirectionImageViewConstraints = [
			windDirectionImageView.widthAnchor.constraint(equalToConstant: 40),
			windDirectionImageView.heightAnchor.constraint(equalToConstant: 40),
			windDirectionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
			windDirectionImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
		]

		let activeConstraints = locationNameLabelConstraints + humidityIconImageViewConstraints + humidityLabelConstraints + windSpeedLabelConstraints + windDirectionImageViewConstraints
		NSLayoutConstraint.activate(activeConstraints)
	}
	
	private func setupLeftSubviewsConstraints() {
		let containerViewConstraints = [
			containerView.topAnchor.constraint(equalTo: topAnchor),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
			containerView.widthAnchor.constraint(equalToConstant: 100)
		]
		
		let weatherIconImageViewConstraints = [
			weatherIconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			weatherIconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -10),
			weatherIconImageView.widthAnchor.constraint(equalToConstant: 40),
			weatherIconImageView.heightAnchor.constraint(equalToConstant: 40)
		]

		let temperatureLabelConstraints = [
			temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 5),
			temperatureLabel.centerXAnchor.constraint(equalTo: weatherIconImageView.centerXAnchor),
		]

		let activeConstraints = containerViewConstraints + weatherIconImageViewConstraints + temperatureLabelConstraints
		NSLayoutConstraint.activate(activeConstraints)
	}
	
}
