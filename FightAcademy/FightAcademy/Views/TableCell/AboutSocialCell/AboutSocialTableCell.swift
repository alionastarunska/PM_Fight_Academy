//
//  AboutSocialTableCell.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import UIKit

class AboutSocialTableCell: UITableViewCell, ReusableTableViewCell {

    @IBOutlet private weak var socialImageView: UIImageView!
    @IBOutlet private weak var socialTextView: SocialTextView!

    func setUpTextView(with attributedLink: NSAttributedString) {
        socialTextView.configure(with: attributedLink)
    }

    func setUpImageView(with image: UIImage) {
        socialImageView.image = image
    }

    func setUpImageView(with imageName: String) {
        socialImageView.image = UIImage(named: imageName)
    }

}

extension AboutSocialTableCell: ConfigurableTableViewCell {

    func configure(with socialNetwork: SocialNetwork) {
        setUpTextView(with: socialNetwork.attributedText)
        setUpImageView(with: socialNetwork.name.lowercased())
    }

}
