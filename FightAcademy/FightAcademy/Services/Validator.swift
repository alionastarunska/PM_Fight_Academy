//
//  Validator.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation

protocol Validating {
    func validate(password: String?) throws
    func validate(phoneNumber: String?) throws
    func validate(name: String?) throws
    func validate(for registerModel: RegistrationModel) throws
    func validate(for authModel: AuthorizationModel) throws
}

enum ValidationError: Error {
    case badPassword(String)
    case badPhoneNumber(String)
    case badName(String)
}

//MARK: - ValidationError

extension ValidationError {
    //TODO: rename
    struct Contnet {
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

struct Validator: Validating {
    func validate(for authModel: AuthorizationModel) throws {
        try validate(password: authModel.password)
        try validate(phoneNumber: authModel.phoneNumber)
    }
    
    func validate(password: String?) throws {
        guard let password = password, password.count >= 8, password.count <= 64  else {
            throw ValidationError.badPassword(ValidationError.Contnet.badPasswordLenght)
        }
        
        let upperMatch = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z]).*?")
        guard upperMatch.evaluate(with: password) else { throw ValidationError.badPassword(ValidationError.Contnet.nonUpperChar) }

        let numberMatch = NSPredicate(format: "SELF MATCHES %@", "(?=.*[0-9]).*?")
        guard numberMatch.evaluate(with: password) else {
            throw  ValidationError.badPassword(ValidationError.Contnet.nonNumber)
        }

        let lowerMatch = NSPredicate(format: "SELF MATCHES %@", "(?=.*[a-z]).*?")
        guard lowerMatch.evaluate(with: password) else {
            throw ValidationError.badPassword(ValidationError.Contnet.nonlowerChar)
        }
    }
    
    func validate(phoneNumber: String?) throws {
        
        guard let phoneNumber = phoneNumber  else {
            throw ValidationError.badPhoneNumber(ValidationError.Contnet.invalidPhoneType)
        }
        
        let phoneNumberRegex = NSPredicate(format: "SELF MATCHES %@", "^(\\+38)?0(39|50|63|66|67|68|91|92|93|94|95|96|97|98|99)\\d{7}$")
        
        guard phoneNumberRegex.evaluate(with: phoneNumber) else {
            throw ValidationError.badPhoneNumber(ValidationError.Contnet.invalidPhoneType)
        }
    }
    
    func validate(name: String?) throws {
        
        guard let name = name, name.count >= 2, name.count <= 64 else {
            throw ValidationError.badName(ValidationError.Contnet.badNameLenght)
        }
    }
    
    func validate(for registerModel: RegistrationModel) throws {
        try self.validate(password: registerModel.password)
        try self.validate(phoneNumber: registerModel.phoneNumber)
        try self.validate(name: registerModel.name)
    }
}
