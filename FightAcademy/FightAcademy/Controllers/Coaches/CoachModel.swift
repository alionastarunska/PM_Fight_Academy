//
//  CoachMock.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 20.03.2021.
//

import Foundation

struct Coach: Codable {

    var id: Int
    var firstName: String
    var lastName: String
    var age: Int
    var description: String?
    var phoneNumber: String?
    var trainings: [String]
    
    var fullName: String { return [firstName, lastName].joined(separator: " ") }

    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case age
        case description
        case phoneNumber
        case trainings = "services"
    }
}

class CoachCellModel {
    
    var coach: Coach
    var isExpanded: Bool
    
    init(coach: Coach, isExpanded: Bool = false) {
        self.coach = coach
        self.isExpanded = isExpanded
    }
}
