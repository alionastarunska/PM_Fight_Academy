//
//  LogginingValidator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

struct LogginingValidator<Validator: LogginingValidationService>: LogginingValidationService {

    typealias RegistraionModel = Validator.CustomLoginModel

    private let validator: Validator

    init(validator: Validator) {
        self.validator = validator
    }

    func validate(password: String) throws {
        try validator.validate(password: password)
    }

    func validate(phone: String) throws {
        try validator.validate(phone: phone)
    }

    func validate(_ model: Validator.CustomLoginModel) throws {
        try validator.validate(model)
    }

}
