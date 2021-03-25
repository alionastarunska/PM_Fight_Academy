//
//  TrainingTime.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

typealias TrainingTime = String

extension Array where Element == TrainingTime {

    static func mockTime() -> [TrainingTime] {

        return (1...7).map { (_) -> TrainingTime in "\(Int.random(in: 0...24))" + ":" + "00" }
    }

}
