//
//  ActivityCollectionViewCell.swift
//  FightAcademy
//
//  Created by Павел Снижко on 25.03.2021.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell, NibLoadable {

    @IBOutlet private weak var activityTitle: UILabel!
    @IBOutlet private weak var coachLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var priceValueLabel: UILabel!
    @IBOutlet private weak var activityTimeLabel: UILabel!
    @IBOutlet private weak var activityDateLabel: UILabel!
    @IBOutlet weak var coachFullNameLabel: UILabel!

    var training: Training? {
        didSet {
            configureCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        training = nil
    }

    func configureCell() {
        activityTitle.text = training?.serviceName
        activityDateLabel.text = training?.date

        if let firstName = training?.coachFirstName, let secondName = training?.coachLastName {
            coachFullNameLabel.text = firstName + " " + secondName
        } else {
            coachFullNameLabel.text = ""
        }

//        if let time = training?.time {
//            activityTimeLabel.text = "\(time)"
//        } else {
//            activityTimeLabel.text = ""
//        }

        activityTimeLabel.text =  training?.time

        if let price = training?.price {
            priceValueLabel.text = "\(price)"
        } else {
            priceValueLabel.text = ""
        }
    }

}
