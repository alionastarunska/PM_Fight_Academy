//
//  ChoosingActivityTableViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

class ChoosingActivityTableViewCell: UITableViewCell, ConfigurableCell, ReusableCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    func configure(with item: TrainingType) {
        nameLabel.text = item.name
        priceLabel.text = "Price: " + "\(item.price)" + " UAH"
    }
}
