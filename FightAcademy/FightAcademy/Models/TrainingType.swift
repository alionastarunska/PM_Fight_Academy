//
//  TrainingType.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

struct TrainingType: Decodable {

    public var id: Int
    public var name: String
    public var description: String?
    public var price: Double

    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
    }

}

extension Array where Element == TrainingType {

    static func mock() -> [TrainingType] {
        return [.init(id: 0, name: "Box", description: "box for kids", price: 100),
                .init(id: 1, name: "Karate", description: "", price: 200),
                .init(id: 2, name: "Wing Chun", description: "", price: 300),
                .init(id: 3, name: "Kalaripayattu", description: "", price: 150),
                .init(id: 4, name: "Savate", description: "Like box but better", price: 200),
                .init(id: 5, name: "Capoeira", description: "Something strange", price: 300),
                .init(id: 6, name: "Taekwondo", description: "Taekwondo", price: 110),
                .init(id: 7, name: "Muay Thai", description: "Muay Thai", price: 200)]
    }
}
