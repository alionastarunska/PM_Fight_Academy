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
    
    var activity: ActivityModel? {
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
        activity = nil
    }
    
    func configureCell() {
        activityTitle.text = activity?.serviceName
        activityDateLabel.text = activity?.date
        
        if let firstName = activity?.coachFirstName, let secondName = activity?.coachLastName {
            coachFullNameLabel.text = firstName + " " + secondName
        } else {
            coachFullNameLabel.text = ""
        }
        
        if let time = activity?.time {
            activityTimeLabel.text = "\(time)"
        } else {
            activityTimeLabel.text = ""
        }
        
        activityTimeLabel.text =  activity?.time

        if let price = activity?.price {
            priceValueLabel.text = "\(price)"
        } else {
            priceValueLabel.text = ""
        }
    }

}
