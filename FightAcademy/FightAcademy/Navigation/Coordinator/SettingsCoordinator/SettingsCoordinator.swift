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
        router.setNewRoot(initialPage)

    }

    private func showError(_ error: Error) {

        let controller = factory.makeAlertController(with: error)

        router.present(controller)

    }

}
