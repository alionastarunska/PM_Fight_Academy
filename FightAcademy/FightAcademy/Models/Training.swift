//
//  Training.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

struct Training: Decodable {

    let serviceName: String
    let date: String
    let time: String
    let coachFirstName: String
    let coachLastName: String
    let price: Double

}

extension Training {

    private static var mocdate: String {
        let date = Date()
        let components = Calendar.current.dateComponents([.month, .day, .year], from: date)
        return "\(components.month!)/" + "\(Int.random(in: components.day!...30))/" + "\(components.year!)"
    }

    private static var moctime: String {
        let date = Date()
        let components = Calendar.current.dateComponents([.hour], from: date)
        return "\(Int.random(in: components.hour!...24))" + ":" + "00"
    }

    init() {
        serviceName = "serviceName"
        date = Self.mocdate
        time = Self.moctime
        coachFirstName = "coachFirstName"
        coachLastName = "coachLastName"
        price = 199.0
    }
}

extension ApiResponse where Item == Training {

    static func mockTime(time: Time) -> ApiResponse<Training> {
        let names = ["Andrei", "Artem", "Kek", "Heh", "Lol", "Meh", "Jenia", "Slavik"]
        let lastnames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Rodriguez"]
        let services = ["Karate", "Wing Chun", "Kalaripayattu", "Savate", "Capoeira", "Taekwondo", "Muay Thai"]
        let price = [1000, 200]


        var arr: [Training] = []

        for _ in 1...15 {
            arr.append(Training(serviceName: services.randomElement()!,
                                date: [TrainingTime].mockDay(time: time).randomElement()!,
                                time: [TrainingTime].mockTime().randomElement()!,
                                coachFirstName: names.randomElement()!,
                                coachLastName: lastnames.randomElement()!,
                                price: Double(price.randomElement()!)))
        }

        let paggination = Paggination(page: 1, totalPages: 1000, hasPreviousPage: false, hasNextPage: true)

        return .init(contents: arr, paggination: paggination)
    }
}

enum Time {
    case future
    case past
}
