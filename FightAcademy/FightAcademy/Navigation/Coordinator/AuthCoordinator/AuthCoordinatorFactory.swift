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
        return RegistrationViewController()
    }

    func makeAuthController() -> Authorization {
        return AuthViewController()
    }

    func makeAlertController(with error: Error) -> UIAlertController {
        let controller = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        return controller
    }

}
