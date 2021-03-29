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

        initialPage.onError = { [ weak self ] error in
            print(error)
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

    private func showActiviyChoosing(_ delegate: BookingDelegate) {

        let viewController = factory.makeChooseActivityViewController()
        viewController.onSelectActivityType = { activity in
            delegate.didSelect(activity)
            self.router.pop()
        }
        router.push(viewController, animated: true)
    }

    private func showCoachesChoosing(_ delegate: BookingDelegate, activity: TrainingType) {

        let viewController = factory.makeChooseCoachViewController(activity: activity)
        viewController.onSelectCoach = { coach in
            delegate.didSelect(coach)
            self.router.pop()
        }

        router.push(viewController, animated: true)
    }

    private func showError(_ error: Error) {

        let controller = factory.makeAlertController(with: error)

        router.present(controller)

    }

}
