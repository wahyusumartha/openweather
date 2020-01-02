//
//  DeviceLocationHandler.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 02.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import Foundation
import CoreLocation


enum DeviceLocationError: Error {
	case locationServiceDisabled
	case generalError(message: String?)
}

protocol DeviceLocationHandling {
	func requestLocation(completionHandler: @escaping (Result<CLLocation, DeviceLocationError>) -> Void)
}

final class DeviceLocationHandler: NSObject, DeviceLocationHandling {

	private let locationManager: CLLocationManager

	private var requestLocationCompletion: ((Result<CLLocation, DeviceLocationError>) -> Void)?
	
	init(locationManager: CLLocationManager = CLLocationManager()) {
		self.locationManager = locationManager
	}
	
	func requestLocation(completionHandler: @escaping (Result<CLLocation, DeviceLocationError>) -> Void) {
		locationManager.requestAlwaysAuthorization()
		locationManager.requestWhenInUseAuthorization()
		
		guard CLLocationManager.locationServicesEnabled() else {
			completionHandler(.failure(.locationServiceDisabled))
			return
		}
	
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		locationManager.delegate = self
		locationManager.startUpdatingLocation()

		requestLocationCompletion = { result in
			completionHandler(result)
		}
	}
}

extension DeviceLocationHandler: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = manager.location else { return }
		requestLocationCompletion?(.success(location))
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		requestLocationCompletion?(.failure(.generalError(message: error.localizedDescription)))
	}
}
