//
//  CHANGELoginModel.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

struct LoginModel: LogginingModelRequirements {

    var password: String
    var phone: String

}

extension LoginModel {

    init() {
        password = ""
        phone = ""
    }

}
