//
//  ChoosingCoachTableViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

class ChoosingCoachTableViewCell: UITableViewCell, ReusableCell, ConfigurableCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
 
    func configure(with item: ChoosingCoachModel) {
        nameLabel.text = item.firstName + " " + item.lastName
        ageLabel.text = "\(item.age)" + " years old"
        phoneNumberLabel.text = item.phoneNumber
        
    }
    
}
