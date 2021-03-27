//
//  SocialTextView.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import UIKit

class SocialTextView: UITextView {

    func configure(with attributedLink: NSAttributedString) {

        attributedText = attributedLink

        linkTextAttributes = [
            .foregroundColor: UIColor.systemYellow
        ]

    }

}
