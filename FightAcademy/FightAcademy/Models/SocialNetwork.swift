//
//  SocialNetwork.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

struct SocialNetwork {

    let name: String
    let link: String

    var attributedText: NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: name.capitalized)
        let url = URL(string: link)

        attributedString.setAttributes([.link: url as Any],
                                       range: NSRange(0..<name.count))

        return attributedString
    }
}
