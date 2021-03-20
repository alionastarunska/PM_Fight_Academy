//
//  RegisterData.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation

struct RegisterData {
    var name: String?
    var phoneNumber: String?
    var password: String?
    
    var isFilled: Bool {
        !(name ?? "").isEmpty  && !(phoneNumber ?? "").isEmpty && !(password ?? "").isEmpty
    }
}
