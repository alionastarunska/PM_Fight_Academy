//
//  ActivityTableViewCell.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/28/21.
//

import UIKit

class ActivityTableViewCell: UITableViewCell, NibLoadable, ReusableTableViewCell {

    @IBOutlet private weak var activityNameLabel: UILabel!
    @IBOutlet private weak var coachFullNameLabel: UILabel!
    @IBOutlet private weak var priceValueLabel: UILabel!
    @IBOutlet private weak var dateValueLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    
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

    func configureTimeLabel(with time: String) {
        timeLabel.text = time
    }


    // TODO: PLZ ADD prepareForReuse for all cells!

}

extension ActivityTableViewCell: ConfigurableTableViewCell {

    func configure(with item: Training) {
        configureNameLabel(with: item.serviceName)
        configureCoachLabel(with: item.coachFullName)
        configureDateLabel(with: item.date)
        configurePriceLabel(with: item.price)
        configureTimeLabel(with: item.time)
    }

}
