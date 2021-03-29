//
//  Validator.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation

enum ValidationError: Error {
    case badPassword(String)
    case badPhoneNumber(String)
    case badName(String)
}

extension ValidationError {

    struct Content {
        static let badPasswordLenght = "Password must be at least 8 chars and not more than 64"
        static let nonUpperChar = "Password must include at least one char from [A-Z]"
        static let nonlowerChar = "Password must include at least one char from [a-z]"
        static let nonNumber = "Password must include at 1 number"
        static let badSymbols = "Password must include latin symbols"
        static let passwordRequired = "Please, fill this field. Password is required!"
        static let invalidPhoneType = "You must use Ukrainian operator. Number must start with (+380)"
        static let badNameFormat = "Not allowed symbols in the name"
        static let badNameLenght = "Now allowed lenght of your name"
        static let unknown = "A wrong password or login"

    }

}

struct Validator: RegistrationValidationService, LogginingValidationService {

    typealias CustomRegistraionModel = RegistrationModel
    typealias CustomLoginModel = LoginModel

    func validate(name: String) throws {

        guard name.count >= 2 && name.count <= 64 else {
            throw ValidationError.badName(ValidationError.Content.badNameLenght)
        }

    }

    func validate(password: String) throws {

        guard password.count >= 8 && password.count <= 64 else {
            throw ValidationError.badPassword(ValidationError.Content.badPasswordLenght)
        }

        let upperMatch = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z]).*?")
        guard upperMatch.evaluate(with: password) else {
            throw ValidationError.badPassword(ValidationError.Content.nonUpperChar)
        }

        let numberMatch = NSPredicate(format: "SELF MATCHES %@", "(?=.*[0-9]).*?")
        guard numberMatch.evaluate(with: password) else {
            throw  ValidationError.badPassword(ValidationError.Content.nonNumber)
        }

        let lowerMatch = NSPredicate(format: "SELF MATCHES %@", "(?=.*[a-z]).*?")
        guard lowerMatch.evaluate(with: password) else {
            throw ValidationError.badPassword(ValidationError.Content.nonlowerChar)
        }

    }

    func validate(phone: String) throws {

        let phoneNumberRegex = NSPredicate(format: "SELF MATCHES %@", "^(\\+38)?0(39|50|63|66|67|68|91|92|93|94|95|96|97|98|99)\\d{7}$")

        guard phoneNumberRegex.evaluate(with: phone) else {
            throw ValidationError.badPhoneNumber(ValidationError.Content.invalidPhoneType)
        }

    }

    func validate(_ model: CustomLoginModel) throws {
        try validate(password: model.password)
        try validate(phone: model.phone)
    }

    func validate(_ model: RegistrationModel) throws {
        try validate(name: model.name)
        try validate(password: model.password)
        try validate(phone: model.phone)
    }

}
