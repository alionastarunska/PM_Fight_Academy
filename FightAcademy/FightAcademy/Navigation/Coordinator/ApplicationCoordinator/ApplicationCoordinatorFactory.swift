//
//  ApplicationCoordinatorFactory.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

protocol ApplicationFactoryProtocol {

    func makeTabbarCoordinator(router: Router) -> FinishFlowCoordinator
    func makeAuthCoordinator(router: Router) -> FinishFlowCoordinator

}

final class ApplicationFactory: ApplicationFactoryProtocol {

    func makeTabbarCoordinator(router: Router) -> FinishFlowCoordinator {
        let coordinator = TabBarCoordinator(router: router)
        return coordinator
    }

    func makeAuthCoordinator(router: Router) -> FinishFlowCoordinator {
        let coordinator = AuthCoordinator(router: router)

        return coordinator
    }

}
