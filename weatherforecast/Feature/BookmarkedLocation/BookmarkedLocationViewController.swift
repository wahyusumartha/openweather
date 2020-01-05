//
//  BookmarkedLocationViewController.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit
import Observable

protocol BookmarkedLocationViewControllerNavigationDelegate: AnyObject {
	func showAddLocation()
	func showErrorMessage(_ message: String?)
	func showDetailWeatherInfo()
	func showHelpScreen()
	func showConfirmationAlert(cityName: String, completion: @escaping () -> Void)
}

final class BookmarkedLocationViewController: UIViewController {

	weak var navigationDelegate: BookmarkedLocationViewControllerNavigationDelegate? {
		didSet {
			viewModel.navigationDelegate = navigationDelegate
		}
	}

	private let viewModel: BookmarkedLocationViewModel
	private var disposal = Disposal()
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		return tableView
	}()

	init(viewModel: BookmarkedLocationViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		viewModel.retrieveBookmarkedLocations()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		title = "location_title".localized
		
		tableView.register(BookmarkedLocationTableViewCell.self,
						   forCellReuseIdentifier: BookmarkedLocationTableViewCell.identifier)
		
		setupSubviews()
		setupConstraints()
		setupRightNavigationBarButtonItem()
		setupLeftNavigationBarButtonItem()
		bindObservable()
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
	
	private func setupLeftNavigationBarButtonItem() {
		let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showHelpScreen))
		leftBarButtonItem.tintColor = .authenticBlue900
		navigationItem.leftBarButtonItem = leftBarButtonItem
	}
	
	@objc private func showAddLocation() {
		viewModel.showAddLocation()
	}
	
	@objc private func showHelpScreen() {
		viewModel.showHelpScreen()
	}
	
	private func bindObservable() {
		viewModel.items.observe { [weak self] (items, _) in
			self?.tableView.reloadData()
			self?.setEmptyTableView()
		}.add(to: &disposal)
	}
	
	private func setEmptyTableView() {
		if viewModel.numberOfRows == 0 {
			tableView.setEmptyView(message: "empty_bookmark_message".localized)
		} else {
			tableView.removeEmptyView()
		}
	}
}

extension BookmarkedLocationViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkedLocationTableViewCell.identifier, for: indexPath) as? BookmarkedLocationTableViewCell
		else {
			return UITableViewCell()
		}

		let configurator = BookmarkLocationTableViewCellConfigurator()
		configurator.configureCell(cell,
								   with: viewModel.items.value[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows
	}
}

extension BookmarkedLocationViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.showDetailWeatherInfo(at: indexPath)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		viewModel.deleteBookmark(at: indexPath)
	}
}
