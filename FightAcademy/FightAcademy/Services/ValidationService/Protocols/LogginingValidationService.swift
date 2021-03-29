//
//  LogginingValidationService.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

protocol LogginingValidationService: PasswordValidationService, PhoneValidationService {

    associatedtype CustomLoginModel: LogginingModelRequirements

    func validate(_ model: CustomLoginModel) throws

}
