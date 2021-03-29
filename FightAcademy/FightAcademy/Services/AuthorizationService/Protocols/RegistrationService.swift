//
//  RegistrationService.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

protocol RegistrationService {

    func registrate(phone: String, password: String, name: String, completion: @escaping (Error?) -> Void)

}
