//
//  HistoryCollectionViewCell.swift
//  FightAcademy
//
//  Created by Павел Снижко on 26.03.2021.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var coachLabel: UILabel!
    @IBOutlet weak var coachFullNameLabel: UILabel!
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var dateValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var activity: ActivityModel? {
        didSet {
            configureCell()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activity = nil
    }
    
    //TODO: think how to make as one cell
    func configureCell() {
        activityNameLabel.text = activity?.serviceName
        dateValueLabel.text = activity?.date
        
        if let firstName = activity?.coachFirstName, let secondName = activity?.coachLastName {
            coachFullNameLabel.text = firstName + " " + secondName
        } else {
            coachFullNameLabel.text = ""
        }
        
        if let price = activity?.price {
            priceValueLabel.text = "\(price)"
        } else {
            priceValueLabel.text = ""
        }
    }

}

// MARK: Layout

extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width * 0.9
        let height = view.bounds.height * 0.12
        return CGSize(width: width, height: height)
        
    }
}
