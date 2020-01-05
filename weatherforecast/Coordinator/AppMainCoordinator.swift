//
//  AppMainCoordinator.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

final class AppMainCoordinator: Coordinator {
	private let window: UIWindow?
	private var addLocationCoordinator: AddLocationCoordinator?
	private var detailWeatherInfoCoordinator: DetailWeatherInfoCoordinator?
	
	init(window: UIWindow?) {
		self.window = window
	}
	
	func startFlow() {
		let viewController = BookmarkedLocationFactory.makeBookmarkedLocationViewController()
		viewController.navigationDelegate = self
		let navigationController = UINavigationController(rootViewController: viewController)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}

extension AppMainCoordinator: BookmarkedLocationViewControllerNavigationDelegate {
	func showAddLocation() {
		addLocationCoordinator = AddLocationCoordinator(navigationController: window?.rootViewController as? UINavigationController)
		addLocationCoordinator?.startFlow()
	}
	
	func showErrorMessage(_ message: String?) {
		let alertController = UIAlertController(title: "Error",
												message: message,
												preferredStyle: .alert)
		let action = UIAlertAction(title: "OK",
								   style: .default)
		alertController.addAction(action)
		
		let navigationController = window?.rootViewController as? UINavigationController
		navigationController?.present(alertController, animated: true)
	}
	
	func showDetailWeatherInfo() {
		detailWeatherInfoCoordinator = DetailWeatherInfoCoordinator(navigationController: window?.rootViewController as? UINavigationController)
		detailWeatherInfoCoordinator?.startFlow()
	}
	
	func showHelpScreen() {
		let helpViewController = HelpViewController()
		let navigationController = window?.rootViewController as? UINavigationController
		navigationController?.pushViewController(helpViewController, animated: true)
	}
}
