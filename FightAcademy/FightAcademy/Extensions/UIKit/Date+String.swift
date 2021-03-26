//
//  Date+String.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 26.03.2021.
//

import Foundation

extension Date {
    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        return formatter.string(from: self)
    }
}

extension Date {
    var removeTimeStamp: Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else { return self }
        return date
    }
}
