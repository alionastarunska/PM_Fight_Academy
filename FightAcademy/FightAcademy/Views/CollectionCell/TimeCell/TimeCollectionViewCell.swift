//
//  TimeCollectionViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 23.03.2021.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell, ReusableCollectionViewCell {

    @IBOutlet private weak var timeSlotLabel: UILabel!

    override var isSelected: Bool {
        didSet {
            timeSlotLabel.textColor = isSelected ? .black : .white
            timeSlotLabel.backgroundColor = isSelected ? Asset.Colors.customYellow.color : Asset.Colors.backgroundColor.color
        }
    }

}

extension TimeCollectionViewCell: ConfigurableCollectionViewCell {

    func configure(with data: TrainingTime) {
        timeSlotLabel.text = data
    }

}
