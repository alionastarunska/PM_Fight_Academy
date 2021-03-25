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
    var description: String
    var phoneNumber: String
    var trainings: [String]
}

class CoachCellModel {
    
    var coach: Coach
    var isExpanded: Bool
    
    init(coach: Coach, isExpanded: Bool = false) {
        self.coach = coach
        self.isExpanded = isExpanded
    }
}

// swiftlint:disable all
struct CoachMock {
    static func make() -> [Coach] {
        return [
            Coach(id: 0, firstName: "Michael", lastName: "Jackson", age: 10, description: "Hello world",
                  phoneNumber: "1020002992", trainings: ["Boxing for kids", "fitness", "gym"]),
            Coach(id: 1, firstName: "Aleksandr", lastName: "Tarasov", age: 30, description: "In life I am a versatile person. Persistent, purposeful, sociable. I love to set challenging tasks for myself and fulfill them. Since for me sport is fun up to a sweat, I train and train with true pleasure. I sincerely believe that it is the personal trainer who is responsible for the athletic success of his wards. Give me the opportunity to unleash your potential - and you will not regret it for a second!", phoneNumber: "+38088888888", trainings: ["Boxing for kids"]),
            Coach(id: 0, firstName: "test 1", lastName: "Test1", age: 10, description: "Hello world", phoneNumber: "102", trainings: ["Boxing for kids"]),
            Coach(id: 1, firstName: "Test2", lastName: "test2", age: 30, description: "In life I am a versatile person. Persistent, purposeful, sociable. I love to set challenging tasks for myself and fulfill them. Since for me sport is fun up to a sweat, I train and train with true pleasure. I sincerely believe that it is the personal trainer who is responsible for the athletic success of his wards. Give me the opportunity to unleash your potential - and you will not regret it for a second!", phoneNumber: "+38088888888", trainings: ["Boxing for kids"]),
            Coach(id: 1, firstName: "Aleksandr", lastName: "Tarasov", age: 30, description: "In life I am a versatile person. Persistent, purposeful, sociable. I love to set challenging tasks for myself and fulfill them. Since for me sport is fun up to a sweat, I train and train with true pleasure. I sincerely believe that it is the personal trainer who is responsible for the athletic success of his wards. Give me the opportunity to unleash your potential - and you will not regret it for a second!", phoneNumber: "+38088888888", trainings: ["Boxing for kids"]),
            Coach(id: 0, firstName: "test 1", lastName: "Test1", age: 10, description: "Hello world", phoneNumber: "102", trainings: ["Boxing for kids"]),
            Coach(id: 1, firstName: "Test2", lastName: "test2", age: 30, description: "In life I am a versatile person. Persistent, purposeful, sociable. I love to set challenging tasks for myself and fulfill them. Since for me sport is fun up to a sweat, I train and train with true pleasure. I sincerely believe that it is the personal trainer who is responsible for the athletic success of his wards. Give me the opportunity to unleash your potential - and you will not regret it for a second!", phoneNumber: "+38088888888", trainings: ["Boxing for kids"]),
            Coach(id: 1, firstName: "Aleksandr", lastName: "Tarasov", age: 30, description: "In life I am a versatile person. Persistent, purposeful, sociable. I love to set challenging tasks for myself and fulfill them. Since for me sport is fun up to a sweat, I train and train with true pleasure. I sincerely believe that it is the personal trainer who is responsible for the athletic success of his wards. Give me the opportunity to unleash your potential - and you will not regret it for a second!", phoneNumber: "+38088888888", trainings: ["Boxing for kids"]),
            Coach(id: 0, firstName: "test 1", lastName: "Test1", age: 10, description: "Hello world", phoneNumber: "102", trainings: ["Boxing for kids"]),
            Coach(id: 1, firstName: "Test2", lastName: "test2", age: 30, description: "In life I am a versatile person. Persistent, purposeful, sociable. I love to set challenging tasks for myself and fulfill them. Since for me sport is fun up to a sweat, I train and train with true pleasure. I sincerely believe that it is the personal trainer who is responsible for the athletic success of his wards. Give me the opportunity to unleash your potential - and you will not regret it for a second!", phoneNumber: "+38088888888", trainings: ["Boxing for kids"])
        ]
    }
}
