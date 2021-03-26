//
//  TrainingDay.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

typealias TrainingDay = String

extension Array where Element == TrainingDay {

    static func mockDay(time: Time) -> [TrainingDay] {
        let date = Date()
        let components = Calendar.current.dateComponents([.month, .day, .year], from: date)

        let range: ClosedRange<Int>
        if time == .future {
            range = components.day!...31
        } else {
            range = 1...components.day!
        }

        return (1...7).map { (_) -> TrainingDay in "\(components.month!)/" + "\(Int.random(in: range))/" + "\(components.year!)" }
    }
}

extension TrainingDay {
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: self) ?? Date()
    }
}
