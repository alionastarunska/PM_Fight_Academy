//
//  ChoosingCoachTableViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

class ChoosingCoachTableViewCell: UITableViewCell, ReusableTableViewCell, ConfigurableTableViewCell {

    @IBOutlet private weak var selectionView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
 
    func configure(with item: Coach) {
        nameLabel.text = item.fullName
        ageLabel.text = "\(item.age)" + " years old"
        phoneNumberLabel.text = item.phoneNumber
        
    }
    
}
