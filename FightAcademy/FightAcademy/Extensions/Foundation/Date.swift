//
//  Date.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 26.03.2021.
//

import Foundation

extension Date {

    func stringed(using dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }

    func withoutTimeStamp() -> Date {

        let currentDate = Date()
        let interestedComponents: Set<Calendar.Component> = [.year, .month, .day]
        let dateComponents = Calendar.current.dateComponents(interestedComponents,
                                                             from: currentDate)

        guard let dateWithoutTimeStamp = Calendar.current.date(from: dateComponents) else {
            return currentDate
        }

        return dateWithoutTimeStamp
    }

    // NOTE: REMOVE
    var removeTimeStamp: Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else { return self }
        return date
    }

}

extension Date {

    static func withoutTimeStamp() -> Date {

        let date = Date()
        let interestedComponents: Set<Calendar.Component> = [.year, .month, .day]
        let dateComponents = Calendar.current.dateComponents(interestedComponents,
                                                             from: date)

        guard let dateWithoutTimeStamp = Calendar.current.date(from: dateComponents) else {
            return date
        }

        return dateWithoutTimeStamp
    }

}
