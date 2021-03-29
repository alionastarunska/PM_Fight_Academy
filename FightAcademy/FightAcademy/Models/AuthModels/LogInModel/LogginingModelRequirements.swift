//
//  LogginingModelRequirements.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

protocol LogginingModelRequirements {

    var password: String { get set }
    var phone: String { get set }

    var isFilled: Bool { get }

    init()
    init(password: String, phone: String)

}

extension LogginingModelRequirements {

    var isFilled: Bool {
        return !password.isEmpty && !phone.isEmpty
    }

}
