//
//  TimeSlots.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 23.03.2021.
//

import Foundation

struct TimeSlot: Codable {
    
    private(set) var date: String
    
    private enum CodingKeys: String, CodingKey {
        case date
    }
}

struct TimeSlotsMock {
    static func make() -> [TimeSlot] {
        return [
            TimeSlot(date: "10:00"),
            TimeSlot(date: "11:00"),
            TimeSlot(date: "12:00"),
            TimeSlot(date: "13:00"),
            TimeSlot(date: "14:00"),
            TimeSlot(date: "15:00"),
            TimeSlot(date: "15:30"),
            TimeSlot(date: "16:15"),
            TimeSlot(date: "18:00"),
            TimeSlot(date: "21:10")
                ]
            }
}
