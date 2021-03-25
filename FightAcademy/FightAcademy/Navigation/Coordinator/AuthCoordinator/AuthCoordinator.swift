//
//  AuthCoordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

final class AuthCoordinator: FinishFlowCoordinator {

    private let factory: AuthFactoryProtocol = AuthFactory()

    override func start() {
        showLogin()
    }

    private func showLogin() {

        let authViewController = factory.makeAuthController()
        authViewController.onCompleteAuth = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }
        authViewController.onSignUpButtonTap = { [weak self] in
            guard let self = self else { return }
            self.showSignUp()
        }
        authViewController.onError = { [weak self] error in
            guard let self = self else { return }
            self.showError(error)
        }
        router.setNewRoot(authViewController)
    }

    private func showSignUp() {

        let signUpView = factory.makeRegController()
        signUpView.onCompleteAuth = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }
        signUpView.onError = { [weak self] error in
            guard let self = self else { return }
            self.showError(error)
        }
        router.push(signUpView)
    }

    private func showError(_ error: Error) {

        let controller = factory.makeAlertController(with: error)

        router.present(controller)

    }

}
