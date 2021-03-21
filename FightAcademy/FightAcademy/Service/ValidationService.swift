//
//  ValidationService.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation

protocol ValidationService {
    func validate(password: String?) throws -> Bool
    func validate(phoneNumber: String?) throws -> Bool
    func validate(name: String?) throws -> Bool
    func validate(for registerModel: RegisterModel) throws -> Bool
    func validate(for authModel: AuthModel)
}


enum ValidationError: String, Error {
    case badPassword
    case badPhoneNumber
    case badName
}

struct DefaultValidationService: ValidationService {
    func validate(for authModel: AuthModel) {
        //TODO: write
    }
    
    
    func validate(password: String?) throws -> Bool {
        guard let password = password  else {
            return false
        }
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        
        guard passwordRegex.evaluate(with: password) else { throw ValidationError.badPassword }
        
        return true
    }
    
    func validate(phoneNumber: String?) throws -> Bool {
        
        guard let phoneNumber = phoneNumber  else {
            return false
        }
        
        let phoneNumberRegex = NSPredicate(format: "SELF MATCHES %@", "^\\+380[5-9][0-9]\\d{7}$")
        guard phoneNumberRegex.evaluate(with: phoneNumber) else { throw ValidationError.badPhoneNumber }
        return true
    }
    
    func validate(name: String?) throws -> Bool {
        
        guard let name = name else {
            return false
        }
        
        let nameRegex = NSPredicate(format: "SELF MATCHES %@", "^[a-z ,.'-]+$$")
        
        guard nameRegex.evaluate(with: name) else { throw ValidationError.badName }
        
        return true
    }
    
    func validate(for registerModel: RegisterModel) throws -> Bool {
        
        let isPassword =  try self.validate(password: registerModel.password)

        let isPhoneNumber = try self.validate(phoneNumber: registerModel.phoneNumber)

        let isName = try self.validate(name: registerModel.name)
        
        return isPassword && isPhoneNumber && isName
    }
}
