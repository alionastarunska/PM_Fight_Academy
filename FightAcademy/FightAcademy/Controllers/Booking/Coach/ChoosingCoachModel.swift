//
//  ChoosingCoachModel.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

struct ChoosingCoachModel: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var age: Int
    var phoneNumber: String
}

// swiftlint:disable all
struct ChoosingCoachMock {
    static func make() -> [ChoosingCoachModel] {
        return [
            ChoosingCoachModel(id: 0, firstName: "Michael", lastName: "Jackson", age: 10,
                  phoneNumber: "1020002992"),
            ChoosingCoachModel(id: 0, firstName: "Вітьок", lastName: "Jackson", age: 66,
                  phoneNumber: "+1020002992"),
            ChoosingCoachModel(id: 0, firstName: "Michael", lastName: "Jackson", age: 10,
                  phoneNumber: "1020002992"),
            ChoosingCoachModel(id: 0, firstName: "Вітьок", lastName: "Jackson", age: 66,
                  phoneNumber: "+1020002992"),
            ChoosingCoachModel(id: 0, firstName: "Michael", lastName: "Jackson", age: 10,
                  phoneNumber: "1020002992"),
            ChoosingCoachModel(id: 0, firstName: "Вітьок", lastName: "Jackson", age: 66,
                  phoneNumber: "+1020002992")
        ]
    }
}
