//
//  RegistrationModel.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

protocol RegistrationModelRequirements {

    var name: String { get set }
    var password: String { get set }
    var phone: String { get set }

    var isFilled: Bool { get }

    init()
    init(name: String, password: String, phone: String)

}

extension RegistrationModelRequirements {

    var isFilled: Bool {
        return !password.isEmpty && !phone.isEmpty && !name.isEmpty
    }

}
