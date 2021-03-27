//
//  HistoryCoordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

final class HistoryCoordinator: FinishFlowCoordinator {

    private var factory: HistoryFactoryProtocol = HistoryFactory()

    override func start() {
        showInitialPage()
    }

    private func showInitialPage() {

        let initialPage = factory.makeHistoryViewController()

        initialPage.closeCoordinator = { [ weak self ] in
            self?.finishFlow?()
        }
        
        router.setNewRoot(initialPage)

    }

}
