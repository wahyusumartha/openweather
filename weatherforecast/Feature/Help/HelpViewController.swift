//
//  HelpViewController.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 05.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit
import WebKit

final class HelpViewController: UIViewController {

	let webView: WKWebView = {
		let webView = WKWebView()
		webView.translatesAutoresizingMaskIntoConstraints = false
		return webView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.addSubview(webView)
		setupConstraints()
		
		loadLocalHtmlFile()
	}
	
	private func setupConstraints() {
		let webViewConstraints = [
			webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			webView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
		]
		
		NSLayoutConstraint.activate(webViewConstraints)
	}
	
	private func loadLocalHtmlFile() {
		guard let url = Bundle.main.url(forResource: "index", withExtension: "html") else { return }
	
		webView.loadFileURL(url, allowingReadAccessTo: url)
		
		let request = URLRequest(url: url)
		webView.load(request)
	}
}
