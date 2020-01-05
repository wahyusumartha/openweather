//
//  DetailWeatherInfoTableViewCell.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 05.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

final class DetailWeatherInfoTableViewCell: UITableViewCell {

	static let identifier = String(describing: self)

	let cardView: DetailWeatherInfoView = {
		let cardView = DetailWeatherInfoView()
		cardView.translatesAutoresizingMaskIntoConstraints = false
		return cardView
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initialSetup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initialSetup()
	}

	private func initialSetup() {
		setupSubviews()
		setupConstraints()
	}
	
	private func setupSubviews() {
		backgroundColor = .clear
		contentView.addSubview(cardView)
	}
	
	private func setupConstraints() {
		let cardViewConstraints = [
			cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		]
		
		NSLayoutConstraint.activate(cardViewConstraints)
	}
}
