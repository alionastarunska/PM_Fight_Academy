//
//  PasswordValidationService.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

protocol PasswordValidationService {

    func validate(password: String) throws

}
