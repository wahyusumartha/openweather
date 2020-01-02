//
//  BookmarkedLocationViewController.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

protocol BookmarkedLocationViewControllerNavigationDelegate: AnyObject {
	func showAddLocation()
}

final class BookmarkedLocationViewController: UIViewController {

	weak var navigationDelegate: BookmarkedLocationViewControllerNavigationDelegate?
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		return tableView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
		tableView.register(BookmarkedLocationTableViewCell.self,
						   forCellReuseIdentifier: BookmarkedLocationTableViewCell.identifier)
		
		setupSubviews()
		setupConstraints()
		setupRightNavigationBarButtonItem()
	}
   
	private func setupSubviews() {
		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)
	}
	
	private func setupConstraints() {
		let tableViewConstraints = [
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		]
		
		NSLayoutConstraint.activate(tableViewConstraints)
	}
	
	private func setupRightNavigationBarButtonItem() {
		let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddLocation))
		rightBarButtonItem.tintColor = .authenticBlue900
		navigationItem.rightBarButtonItem = rightBarButtonItem
	}
	
	@objc private func showAddLocation() {
		navigationDelegate?.showAddLocation()
	}
}

extension BookmarkedLocationViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkedLocationTableViewCell.identifier, for: indexPath) as? BookmarkedLocationTableViewCell
		else {
			return UITableViewCell()
		}
	
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
}

extension BookmarkedLocationViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
}
