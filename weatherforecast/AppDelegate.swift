//
//  AppDelegate.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	// MARK: - Public Properties
	var window: UIWindow?

	// MARK: - Lifecycles
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		setupInitialUserInterface()
		return true
	}

	// MARK: - Private Methods
	private func setupInitialUserInterface() {
		window = UIWindow(frame: UIScreen.main.bounds)
		
		let rootViewController = BookmarkedLocationViewController()
		let navigationController = UINavigationController(rootViewController: rootViewController)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
