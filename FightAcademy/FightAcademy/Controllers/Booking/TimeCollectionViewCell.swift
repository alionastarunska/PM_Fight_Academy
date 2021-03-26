//
//  TimeCollectionViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 23.03.2021.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell, ReusableCell, ConfigurableCell {

    @IBOutlet private weak var timeSlotLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            timeSlotLabel.textColor = isSelected ? .black : .white
            timeSlotLabel.backgroundColor = isSelected ? Asset.Colors.customYellow.color : Asset.Colors.backgroundColor.color
        }
    }
    
    func configure(with data: TrainingTime) {
        timeSlotLabel.text = data
    }
}
