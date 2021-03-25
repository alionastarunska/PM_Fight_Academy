//
//  ChoosingActivityModel.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import Foundation

struct ChoosingActivityModel: Codable {
    var id: Int
    var name: String
    var price: Int
   
}

// swiftlint:disable all
struct ChoosingActivityMock {
    static func make() -> [ChoosingActivityModel] {
        return [
            ChoosingActivityModel(id: 0, name: "Boxing", price: 10000),
            ChoosingActivityModel(id: 0, name: "Fitness", price: 100),
            ChoosingActivityModel(id: 0, name: "MMA", price: 150),
            ChoosingActivityModel(id: 0, name: "Swimming", price: 10),
            ChoosingActivityModel(id: 0, name: "Boxing", price: 10)
        ]
    }
}
