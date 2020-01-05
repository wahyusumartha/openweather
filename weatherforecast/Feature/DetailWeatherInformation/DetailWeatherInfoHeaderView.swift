//
//  DetailWeatherInfoHeaderView.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

final class DetailWeatherInfoHeaderView: UIView {

	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .leading
		stackView.distribution = .equalSpacing
		return stackView
	}()

	let locationLabel: UILabel = {
		let locationLabel = UILabel()
		locationLabel.translatesAutoresizingMaskIntoConstraints = false
		locationLabel.textColor = .white
		locationLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		return locationLabel
	}()
	
	let weatherDescriptionLabel: UILabel = {
		let weatherDescriptionLabel = UILabel()
		weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		weatherDescriptionLabel.textColor = .white
		weatherDescriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
		return weatherDescriptionLabel
	}()
	
	let weatherImageView: UIImageView = {
		let weatherImageView = UIImageView()
		weatherImageView.translatesAutoresizingMaskIntoConstraints = false
		weatherImageView.backgroundColor = .clear
		return weatherImageView
	}()
	
	private let topContainerView: UIView = {
		let topContainerView = UIView()
		topContainerView.translatesAutoresizingMaskIntoConstraints = false
		topContainerView.backgroundColor = .positiveGreen1000
		topContainerView.layer.cornerRadius = 4
		return topContainerView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	
	func addWeatherInfoToStackView(titleText: String, infoText: String) {
		let weatherInfoStackView = createWeatherInfoStackView(titleText: titleText,
															  infoText: infoText)
		stackView.addArrangedSubview(weatherInfoStackView)
	}
	
	private func setupSubviews() {
		layer.cornerRadius = 4
		backgroundColor = .positiveGreen900
		
		topContainerView.addSubview(locationLabel)
		topContainerView.addSubview(weatherDescriptionLabel)
		topContainerView.addSubview(weatherImageView)
		addSubview(topContainerView)
		
		addSubview(stackView)
	}
	
	private func createWeatherInfoStackView(titleText: String, infoText: String) -> UIStackView {
		let stackView = UIStackView()
		stackView.alignment = .center
		stackView.distribution = .fillEqually
		stackView.axis = .vertical
		
		let titleLabel = UILabel()
		titleLabel.textColor = .white
		titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		titleLabel.textAlignment = .left
		titleLabel.text = titleText
		
		let infoLabel = UILabel()
		infoLabel.textColor = .white
		infoLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		infoLabel.textAlignment = .left
		infoLabel.text = infoText

		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(infoLabel)
		
		return stackView
	}
	
	private func setupConstraints() {
		let topContainerViewConstraints = [
			topContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			topContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
			topContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
			topContainerView.heightAnchor.constraint(equalToConstant: 120)
		]
		
		let locationLabelConstraints = [
			locationLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 10),
			locationLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor)
		]
		
		let weatherDescriptionLabelConstraints = [
			weatherDescriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
			weatherDescriptionLabel.centerXAnchor.constraint(equalTo: locationLabel.centerXAnchor)
		]

		let weatherImageViewConstraints = [
			weatherImageView.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 5),
			weatherImageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
			weatherImageView.widthAnchor.constraint(equalToConstant: 50),
			weatherImageView.heightAnchor.constraint(equalToConstant: 50)
		]
		
		let stackViewConstraints = [
			stackView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 5),
			stackView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -5),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
		]

		let activeConstraints = topContainerViewConstraints + locationLabelConstraints + weatherDescriptionLabelConstraints + weatherImageViewConstraints + stackViewConstraints
		
		NSLayoutConstraint.activate(activeConstraints)
	}}
