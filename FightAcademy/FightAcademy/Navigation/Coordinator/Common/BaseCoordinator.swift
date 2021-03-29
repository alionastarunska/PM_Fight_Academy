//
//  BaseCoordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

class BaseCoordinator: Coordinator {

    private(set) var router: Router
    private(set) var childCoordinators: [Coordinator] = []

    required init(router: Router) {
        self.router = router
    }

    func add(_ coordinator: Coordinator) {
        let alreadyHas = childCoordinators.contains { $0 === coordinator }
        guard !alreadyHas else {
            fatalError("Unable to add same coordinator twice!")
        }
        childCoordinators.append(coordinator)
    }

    func remove(_ coordinator: Coordinator) {
        guard childCoordinators.isEmpty == false else { return }

        removeLoop: for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break removeLoop
        }
    }

    func start() { }

}
