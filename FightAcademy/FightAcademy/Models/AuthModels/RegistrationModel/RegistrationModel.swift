//
//  RegistrationModel.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

struct RegistrationModel: RegistrationModelRequirements {

    var name: String
    var password: String
    var phone: String

}

extension RegistrationModel {

    init() {
        name = ""
        password = ""
        phone = ""
    }

}
