//
//  RCKey.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

enum RCKey: String {

    case description
    case article
    case phoneNumber
    case adress

    enum SocialNetworks: String, CaseIterable {

        case facebook
        case instagram
        case youtube

    }

}
