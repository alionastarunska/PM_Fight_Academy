//
//  CoachTableViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 20.03.2021.
//

import UIKit

typealias Event = () -> Void

class CoachTableViewCell: UITableViewCell, ConfigurableCell, ReusableCell {
    
    var expandEvent: Event?
    
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var trainingLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var showMoreButton: UIButton!
    
    private weak var model: CoachCellModel?
    @IBAction private func showMoreButtonAction(_ sender: UIButton) {
        descriptionLabel.numberOfLines = 0
        showMoreButton.isHidden = true
        model?.isExpanded = true
        expandEvent?()
    }
    
    func configure(with item: CoachCellModel) {
        model = item
        nameLabel.text = item.coach.firstName + " " + item.coach.lastName
        ageLabel.text = "\(item.coach.age)" + " years old"
        phoneNumberLabel.text = item.coach.phoneNumber
        descriptionLabel.text = item.coach.description
        trainingLabel.text = item.coach.trainings?.joined(separator: ", ")
        if item.isExpanded {
            descriptionLabel.numberOfLines = .zero
            showMoreButton.isHidden = true
        } else {
            descriptionLabel.numberOfLines = .collapsedLines
            if sizeOf(string: descriptionLabel.text ?? "", font: descriptionLabel.font, constrainedToWidth: .labelWidth) < .linesHeight {
                showMoreButton.isHidden = true
            } else {
                showMoreButton.isHidden = false
            }
        }
    }
    
    // MARK: - Private
    
    private func sizeOf(string: String, font: UIFont, constrainedToWidth width: CGFloat) -> CGFloat {
        return NSString(string: string).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [.font: font],
                                                     context: nil).height
    }
}

private extension CGFloat {
    static var labelWidth: CGFloat { return UIScreen.main.bounds.width - 44.0 }
    static var linesHeight: CGFloat { return 51 }
}

private extension Int {
    static var collapsedLines: Int { return 3 }
}
