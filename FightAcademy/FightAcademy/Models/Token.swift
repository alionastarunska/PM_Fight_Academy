//
//  Token.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

struct Token: Decodable {

    let raw: String

    enum CodingKeys: String, CodingKey {
        case raw = "token"
    }
}
