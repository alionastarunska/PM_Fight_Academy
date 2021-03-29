//
//  ApiResponse.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

public struct ApiResponse<Item: Decodable>: Decodable {

    public let contents: [Item]

    public let paggination: Paggination

    public enum CodingKeys: String, CodingKey {
        case contents = "data"
        case paggination = "paggination"
    }

}
