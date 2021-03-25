//
//  ApplicationCoordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {

    private let factory: ApplicationFactoryProtocol = ApplicationFactory()
    private var isAutorized: Bool = SessionStorage().sessionId != nil

    override func start() {

        switch isAutorized {
        case false: runAuthFlow()
        case true: runMainFlow()
        }
    }
    
    private func runAuthFlow() {
        let coordinator = factory.makeAuthCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            self.isAutorized = true
            self.start()
            self.remove(coordinator)
        }
        add(coordinator)
        coordinator.start()
    }

    private func runMainFlow() {
        let coordinator = factory.makeTabbarCoordinator(router: router)
        add(coordinator)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            // TODO: maybe there will make sessionId = nil 
            self.isAutorized = false
            self.start()
            self.remove(coordinator)
        }
        coordinator.start()
    }

}
