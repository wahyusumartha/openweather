//
//  DetailWeatherInfoViewController.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit
import Kingfisher

final class DetailWeatherInfoViewController: UIViewController {

	private let headerView: DetailWeatherInfoHeaderView = {
		let headerView = DetailWeatherInfoHeaderView()
		headerView.translatesAutoresizingMaskIntoConstraints = false
		return headerView
	}()

	private let viewModel: DetailWeatherInfoViewModel
	
	init(viewModel: DetailWeatherInfoViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
		title = "today_weather_title".localized
		
		setupSubviews()
		setupConstraints()
    }
	
	private func setupSubviews() {
		view.backgroundColor = .authenticBlue50
		view.addSubview(headerView)

		viewModel.weatherInformations.forEach {
			self.headerView.addWeatherInfoToStackView(titleText: $0.title, infoText: $0.info)
		}
	
		headerView.locationLabel.text = viewModel.headerItem.locationName
		headerView.weatherDescriptionLabel.text = viewModel.headerItem.weatherInfo
		headerView.weatherImageView.kf.setImage(with: viewModel.headerItem.iconURL)
	}
	
	private func setupConstraints() {
		let headerViewConstraints = [
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			headerView.heightAnchor.constraint(equalToConstant: 180)
		]
		
		NSLayoutConstraint.activate(headerViewConstraints)
	}
}
