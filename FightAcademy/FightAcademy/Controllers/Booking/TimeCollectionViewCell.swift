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
            timeSlotLabel.backgroundColor = isSelected ? .main : .background
        }
    }
    
    func configure(with data: TimeSlot) {
        timeSlotLabel.text = data.date
    }
}

// TODO: Move to assets or public extension

extension UIColor {
    static var main: UIColor { return UIColor(red: 244/255.0, green: 225/255.0, blue: 51/255.0, alpha: 1) }
    static var background: UIColor { return UIColor(red: 49/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1) }
}
