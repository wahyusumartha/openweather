//
//  DetailWeatherInfoCoordinator.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

final class DetailWeatherInfoCoordinator: Coordinator {

	private weak var navigationController: UINavigationController?
	
	init(navigationController: UINavigationController?) {
		self.navigationController = navigationController
	}
	
	func startFlow() {
		let detailWeatherInformationViewController = DetailWeatherInfoFactory.makeDetailWeatherInfoViewController()
		navigationController?.pushViewController(detailWeatherInformationViewController, animated: true)
	}
}
