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
        
        // TODO: maybe provide some DI class for these objects
        let sessionStorage =  SessionStorage()
        
        let apiClient = ProfileApiClient(networkService: MockNetworkManager(), jsonEcoder: JSONEncoder())
        
        let authService = AuthorizationService(sessionStorage: sessionStorage, profileApiClient: apiClient)
        
        let validator = Validator()
        
        return RegisterViewController(validationService: validator, authService: authService)
    }

    func makeAuthController() -> Authorization {
        
        // TODO: maybe provide some DI class for these objects
        let validator = Validator()
        let sessionStorage =  SessionStorage()
        let apiClient = ProfileApiClient(networkService: MockNetworkManager(), jsonEcoder: JSONEncoder())
        let authService = AuthorizationService(sessionStorage: sessionStorage, profileApiClient: apiClient)

        return LogInViewController(validationService: validator, authService: authService)
    }

    func makeAlertController(with error: Error) -> UIAlertController {
        let controller = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        return controller
    }

}
