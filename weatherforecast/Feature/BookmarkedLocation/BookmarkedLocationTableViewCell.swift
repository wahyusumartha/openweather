//
//  BookmarkedLocationTableViewCell.swift
//  weatherforecast
//
//  Created by Wahyu Sumartha Priya Dharma on 01.01.20.
//  Copyright © 2020 Wahyu Sumartha Priya Dharma. All rights reserved.
//

import UIKit

final class BookmarkedLocationTableViewCell: UITableViewCell {

	static let identifier = String(describing: self)

	let cardView: BookmarkLocationCardView = {
		let cardView = BookmarkLocationCardView(frame: .zero)
		cardView.translatesAutoresizingMaskIntoConstraints = false
		return cardView
	}()


	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		setupSubviews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func setupSubviews() {
		contentView.addSubview(cardView)
	}

	private func setupConstraints() {
		let cardViewConstraints = [
			cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
			cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
			cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
			cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
		]
		
		NSLayoutConstraint.activate(cardViewConstraints)
	}
}
