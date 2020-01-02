//
//  AddLocationCoordinator.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

final class AddLocationCoordinator: Coordinator {

	private let navigationController: UINavigationController?

	init(navigationController: UINavigationController?) {
		self.navigationController = navigationController
	}

	func startFlow() {
		let addLocationViewController = AddLocationFactory().makeAddLocationViewController()
		addLocationViewController.navigationDelegate = self
		navigationController?.pushViewController(addLocationViewController, animated: true)
	}
}

extension AddLocationCoordinator: AddLocationViewControllerNavigationDelegate {
	func showAlert(with message: String?) {
		let alertController = UIAlertController(title: "Error",
												message: message,
												preferredStyle: .alert)
		let action = UIAlertAction(title: "OK",
								   style: .default)
		alertController.addAction(action)
		navigationController?.present(alertController, animated: true)
	}
	
	func showBookmarkList() {
		navigationController?.popViewController(animated: true)
	}
}
