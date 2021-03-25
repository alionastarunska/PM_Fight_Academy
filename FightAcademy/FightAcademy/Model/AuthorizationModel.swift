//
//  AuthModel.swift
//  FightAcademy
//
//  Created by Павел Снижко on 21.03.2021.
//

import Foundation

class AuthorizationModel: BaseAuthModel {
        
    var isFilled: Bool {
        !(phoneNumber ?? "").isEmpty && !(password ?? "").isEmpty
    }
    
}
