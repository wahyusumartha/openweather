//
//  AddLocationCoordinator.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

final class AddLocationCoordinator: Coordinator {

	private weak var navigationController: UINavigationController?
	
	init(navigationController: UINavigationController?) {
		self.navigationController = navigationController
	}

	func startFlow() {
		let addLocationViewController = AddLocationFactory().makeAddLocationViewController()
		navigationController?.pushViewController(addLocationViewController, animated: true)
	}
}
