//
//  CoachTableViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 20.03.2021.
//

import UIKit

class CoachTableViewCell: UITableViewCell, ReusableTableViewCell, ExpandableTableViewCell {

    private static var collapsedLines: Int { return 3 }
    private static var labelWidth: CGFloat { return UIScreen.main.bounds.width - 44.0 }
    private static var linesHeight: CGFloat { return 51 }

    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var phoneNumberButton: UIButton!
    @IBOutlet private weak var trainingLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var showMoreButton: UIButton!

    var expandEvent: Event?

    private weak var model: CoachCellModel?

    @IBAction private func showMoreButtonAction(_ sender: UIButton) {
        descriptionLabel.numberOfLines = 0
        showMoreButton.isHidden = true
        model?.isExpanded = true
        expandEvent?()
    }

    @IBAction func phoneNumberButtonAction(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + (model?.coach.phoneNumber ?? "")) else { return }
           UIApplication.shared.open(number)
    }

    func сonfigureNameLabel(with name: String) {
        nameLabel.text = name
    }

    func сonfigureAgeLabel(with age: Int) {
        ageLabel.text = "\(age) years old"
    }

    func сonfigureNumberLabel(with number: String?) {
        phoneNumberButton.setTitle(number, for: .normal)
    }

    func сonfigureDescriptionLabel(with description: String?) {
        descriptionLabel.text = description
    }

    func configureSpecLabel(with specs: [String]) {
        trainingLabel.text = specs.joined(separator: ", ")
    }

    func сonfigureShowMoreButton(_ isExpanded: Bool) {
        if isExpanded {
            descriptionLabel.numberOfLines = .zero
            showMoreButton.isHidden = true
        } else {
            descriptionLabel.numberOfLines = Self.collapsedLines
            if descriptionLabel.height(with: Self.labelWidth) < Self.linesHeight {
                showMoreButton.isHidden = true
            } else {
                showMoreButton.isHidden = false
            }
        }
    }

}

extension CoachTableViewCell: ConfigurableTableViewCell {

    func configure(with item: CoachCellModel) {
        model = item
        сonfigureNameLabel(with: item.coach.fullName)
        сonfigureAgeLabel(with: item.coach.age)
        сonfigureNumberLabel(with: item.coach.phoneNumber)
        сonfigureDescriptionLabel(with: item.coach.description)
        configureSpecLabel(with: item.coach.trainings)
        сonfigureShowMoreButton(item.isExpanded)
    }

}
