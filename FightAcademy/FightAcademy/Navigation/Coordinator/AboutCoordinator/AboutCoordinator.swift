//
//  AboutCoordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

final class AboutCoordinator: FinishFlowCoordinator {

    private var factory: AboutFactoryProtocol = AboutFactory()

    override func start() {
        showInitialPage()
    }

    private func showInitialPage() {

        let initialPage = factory.makeAboutViewController()
        router.setNewRoot(initialPage)

    }

}
