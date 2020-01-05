//
//  DetailWeatherInfoViewController.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 04.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit
import Kingfisher
import Observable

protocol DetailWeatherInfoViewControllerNavigationDelegate: class {
	func showErrorMessage(_ message: String?)
}

final class DetailWeatherInfoViewController: UIViewController {

	weak var navigationDelegate: DetailWeatherInfoViewControllerNavigationDelegate? {
		didSet {
			viewModel.navigationDelegate = navigationDelegate
		}
	}
	
	private let headerView: DetailWeatherInfoHeaderView = {
		let headerView = DetailWeatherInfoHeaderView()
		headerView.translatesAutoresizingMaskIntoConstraints = false
		return headerView
	}()

	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		return tableView
	}()
	
	private let viewModel: DetailWeatherInfoViewModel
	
	private var disposal = Disposal()

	init(viewModel: DetailWeatherInfoViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
		title = "today_weather_title".localized
		
		setupSubviews()
		setupConstraints()
		bindObservable()
		
		viewModel.retrieveFiveDaysWeatherForecast()
    }
	
	private func setupSubviews() {
		view.backgroundColor = .authenticBlue50
		view.addSubview(headerView)
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(DetailWeatherInfoTableViewCell.self,
						   forCellReuseIdentifier: DetailWeatherInfoTableViewCell.identifier)
		view.addSubview(tableView)

		viewModel.weatherInformations.forEach {
			self.headerView.addWeatherInfoToStackView(titleText: $0.title, infoText: $0.info)
		}
	
		headerView.locationLabel.text = viewModel.headerItem.locationName
		headerView.weatherDescriptionLabel.text = viewModel.headerItem.weatherInfo
		headerView.weatherImageView.kf.setImage(with: viewModel.headerItem.iconURL)
	}
	
	private func setupConstraints() {
		let headerViewConstraints = [
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			headerView.heightAnchor.constraint(equalToConstant: 180)
		]
		
		let tableViewConstraints = [
			tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		]
		
		let activeConstraints = headerViewConstraints + tableViewConstraints
		
		NSLayoutConstraint.activate(activeConstraints)
	}
	
	private func bindObservable() {
		viewModel.items.observe { [weak self] (items, _) in
			self?.tableView.reloadData()
		}.add(to: &disposal)
	}
}

extension DetailWeatherInfoViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: DetailWeatherInfoTableViewCell.identifier,
													 for: indexPath) as? DetailWeatherInfoTableViewCell
		else {
			return UITableViewCell()
		}

		let configurator = DetailWeatherInfoTableViewCellConfigurator()
		configurator.configureCell(cell, item: viewModel.items.value[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.items.value.count
	}
}

extension DetailWeatherInfoViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
}
