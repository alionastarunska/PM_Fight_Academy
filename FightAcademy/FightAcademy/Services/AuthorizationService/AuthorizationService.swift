//
//  AuthorizationService.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation

struct AuthorizationService: LogInService, RegistrationService {

    private let service: LogInService & RegistrationService

    init(authorizationService: LogInService & RegistrationService) {
        service = authorizationService
    }

    func logIn(phone: String, password: String, completion: @escaping (Error?) -> Void) {
        service.logIn(phone: phone, password: password, completion: completion)
    }

    func registrate(phone: String, password: String, name: String, completion: @escaping (Error?) -> Void) {
        service.registrate(phone: phone, password: password, name: name, completion: completion)
    }

}
