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
	
	init(window: UIWindow?) {
		self.window = window
	}
	
	func startFlow() {
		let viewController = BookmarkedLocationFactory().makeBookmarkedLocationViewController()
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
		
	}
}
