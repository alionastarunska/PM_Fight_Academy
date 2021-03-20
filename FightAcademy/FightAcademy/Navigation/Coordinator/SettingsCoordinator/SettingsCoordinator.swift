//
//  SettingsCoordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

final class SettingsCoordinator: FinishFlowCoordinator {

    private var factory: SettingsFactoryProtocol = SettingsFactory()

    override func start() {
        showInitialPage()
    }

    private func showInitialPage() {

        let initialPage = factory.makeSettingsViewController()

        initialPage.onLogOut = finishFlow
        initialPage.onChangeButtonTapped = showChangePasswordPage

        router.setNewRoot(initialPage)

    }

    private func showChangePasswordPage() {

        let changePasswordPage = factory.makePasswordChangeViewController()

        changePasswordPage.onError = showError
        changePasswordPage.onSuccess = {
            self.router.pop(animated: true)
        }

        router.push(changePasswordPage, animated: true)
    }

    private func showError(_ error: Error) {

        let controller = factory.makeAlertController(with: error)

        router.present(controller)

    }

}
