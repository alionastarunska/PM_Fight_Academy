//
//  RegistrationValidationService.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

protocol RegistrationValidationService: NameValidationService, PasswordValidationService, PhoneValidationService {

    associatedtype CustomRegistraionModel: RegistrationModelRequirements

    func validate(_ model: CustomRegistraionModel) throws

}
