//
//  TabBarCoordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

class TabBarCoordinator: FinishFlowCoordinator {
    
    private let factory: TabBarFactoryProtocol = TabBarFactory()

    override func start() {
        runMainFlow()
    }

    private func runMainFlow() {

        let tabContrroller = factory.makeTabBarController()

        let pages = factory.makeTabBarPages()

        tabContrroller.viewControllers = pages.map { $0.nc }

        pages.map { $0.coord }.forEach(configureCoordinator)
        
        // set root after coord-config
        router.setNewRoot(tabContrroller, hideBar: true)

    }

    private func configureCoordinator(_ coordinator: FinishFlowCoordinator) {

        self.add(coordinator)
        coordinator.finishFlow = self.finishFlow
        coordinator.start()

    }
}
