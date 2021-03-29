//
//  CoachesCoordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

final class CoachesCoordinator: FinishFlowCoordinator {

    private var factory: CoachesFactoryProtocol = CoachesFactory()

    override func start() {
        showInitialPage()
    }

    private func showInitialPage() {

        let initialPage = factory.makeCoachesViewController()
        router.setNewRoot(initialPage)

    }

}
