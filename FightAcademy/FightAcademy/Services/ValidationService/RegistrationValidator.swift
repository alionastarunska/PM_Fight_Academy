//
//  RegistrationValidator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

struct RegistrationValidator<Validator: RegistrationValidationService>: RegistrationValidationService {

    typealias RegistraionModel = Validator.CustomRegistraionModel

    private let validator: Validator

    init(validator: Validator) {
        self.validator = validator
    }

    func validate(name: String) throws {
        try validator.validate(name: name)
    }

    func validate(password: String) throws {
        try validator.validate(password: password)
    }

    func validate(phone: String) throws {
        try validator.validate(phone: phone)
    }

    func validate(_ model: Validator.CustomRegistraionModel) throws {
        try validator.validate(model)
    }

}
