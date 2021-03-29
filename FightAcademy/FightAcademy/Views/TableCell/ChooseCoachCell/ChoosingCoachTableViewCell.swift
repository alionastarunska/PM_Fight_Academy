//
//  ChoosingCoachTableViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

class ChoosingCoachTableViewCell: UITableViewCell, ReusableTableViewCell {

    @IBOutlet private weak var selectionView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!

    func configureNameLabel(with name: String) {
        nameLabel.text = name
    }

    func configureAgeLabel(with age: Int) {
        ageLabel.text = "\(age) years old"
    }

    func configurePhoneLabel(with phone: String) {
        phoneNumberLabel.text = phone
    }

}

extension ChoosingCoachTableViewCell: ConfigurableTableViewCell {

    func configure(with item: Coach) {
        configureNameLabel(with: item.fullName)
        configureAgeLabel(with: item.age)
        configurePhoneLabel(with: item.phoneNumber ?? "")
    }

}
