//
//  UITableView+EmptyView.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 05.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

extension UITableView {
	func setEmptyView(message: String) {
		
		let emptyView = UIView(frame: CGRect(x: center.x,
											 y: center.y,
											 width: bounds.size.width,
											 height: bounds.size.height))

		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .authenticBlue900
		label.numberOfLines = 0
		label.textAlignment = .center
		label.text = message
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
	
		emptyView.addSubview(label)
				
		let labelConstraints = [
			label.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
			label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
			label.leadingAnchor.constraint(greaterThanOrEqualTo: emptyView.leadingAnchor),
			label.trailingAnchor.constraint(lessThanOrEqualTo: emptyView.trailingAnchor)
		]
		
		NSLayoutConstraint.activate(labelConstraints)

		emptyView.setNeedsLayout()
		emptyView.layoutIfNeeded()
		
		backgroundView = emptyView
	}
	
	func removeEmptyView() {
		backgroundView = nil
	}
}
