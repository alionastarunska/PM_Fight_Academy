//
//  AuthCoordinatorFactory.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol AuthFactoryProtocol {

    func makeAuthController() -> Authorization
    func makeRegController() -> Registering
    func makeAlertController(with error: Error) -> UIAlertController

}

final class AuthFactory: AuthFactoryProtocol {

    func makeRegController() -> Registering {

        let authorizationService = AuthorizationService(authorizationService: PMFightApi.shared)

        let validator = RegistrationValidator(validator: Validator())

        return RegisterViewController(validationService: validator,
                                      authService: authorizationService)
    }

    func makeAuthController() -> Authorization {

        let validator = LogginingValidator(validator: Validator())
        let authorizationService = AuthorizationService(authorizationService: PMFightApi.shared)

        return LogInViewController(validationService: validator,
                                   authService: authorizationService)
    }

    func makeAlertController(with error: Error) -> UIAlertController {
        let controller = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        return controller
    }

}
