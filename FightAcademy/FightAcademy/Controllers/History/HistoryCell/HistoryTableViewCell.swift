//
//  HistoryTableViewCell.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/28/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell, NibLoadable, ReusableTableViewCell {

    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var coachFullNameLabel: UILabel!
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var dateValueLabel: UILabel!

    func configureNameLabel(with name: String) {
        activityNameLabel.text = name
    }

    func configureCoachLabel(with name: String) {
        coachFullNameLabel.text = name
    }

    func configurePriceLabel(with price: Double) {
        priceValueLabel.text = "\(price) UAH"
    }

    func configureDateLabel(with date: String) {
        dateValueLabel.text = date
    }

    // note: PLZ ADD prepareForReuse for all cells!

}

extension HistoryTableViewCell: ConfigurableTableViewCell {

    func configure(with item: Training) {
        configureNameLabel(with: item.serviceName)
        configureCoachLabel(with: item.coachFullName)
        configureDateLabel(with: item.date)
        configurePriceLabel(with: item.price)
    }

}
