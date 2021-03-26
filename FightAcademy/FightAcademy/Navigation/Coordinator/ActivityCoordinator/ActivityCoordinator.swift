//
//  ActivityCoordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

final class ActivityCoordinator: FinishFlowCoordinator {

    private var factory: ActivityFactoryProtocol = ActivityFactory()

    override func start() {
        showInitialPage()
    }

    private func showInitialPage() {

        let initialPage = factory.makeActivityViewController()

        initialPage.onActivityStartBooking = showNewActiviyChoosing
        
        initialPage.closeCoordinator = { [ weak self ] in
            self?.finishFlow?()
        }
        
        router.setNewRoot(initialPage)

    }

    private func showNewActiviyChoosing() {

        let viewController = factory.makeNewActivityViewController()
        viewController.onSelectCoach = showCoachesChoosing
        viewController.onSelectActivityType = showActiviyChoosing
        viewController.onRequestActivity = { self.router.pop() }
        router.push(viewController)
    }

    private func showActiviyChoosing() {

        let viewController = factory.makeChooseActivityViewController()
        viewController.onSelectActivityType = {
            self.router.pop()
        }
        router.push(viewController, animated: true)
    }

    private func showCoachesChoosing() {

        let viewController = factory.makeChooseCoachViewController()
        viewController.onSelectCoach = {
            self.router.pop()
        }

        router.push(viewController, animated: true)
    }

    private func showError(_ error: Error) {

        let controller = factory.makeAlertController(with: error)

        router.present(controller)

    }

}
