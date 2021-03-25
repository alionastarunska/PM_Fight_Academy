//
//  ApiResponse.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

struct ApiResponse<Item: Decodable>: Decodable {

    let contents: [Item]

    let paggination: Paggination

    enum CodingKeys: String, CodingKey {
        case contents = "data"
        case paggination = "paggination"
    }

}
