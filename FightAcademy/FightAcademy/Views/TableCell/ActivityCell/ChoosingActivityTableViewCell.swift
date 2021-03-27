//
//  ChoosingActivityTableViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

class ChoosingActivityTableViewCell: UITableViewCell, ReusableTableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    func configureNameLabel(with name: String) {
        nameLabel.text = name
    }

    func configurePriceLabel(with price: Double) {
        priceLabel.text = "Price: " + "\(price)" + " UAH"
    }

}

extension ChoosingActivityTableViewCell: ConfigurableTableViewCell {

    func configure(with item: TrainingType) {
        configureNameLabel(with: item.name)
        configurePriceLabel(with: item.price)
    }

}
