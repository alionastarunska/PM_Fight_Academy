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
        
        // TODO: mock for getting more  activities
        // swift
        // swiftlint:disable all
        SessionStorage().sessionId = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiMDkzMjI2NzYzMSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvdXNlcmRhdGEiOiI3IiwibmJmIjoxNjE2ODMxNDIyLCJleHAiOjE2MTc0MzYyMjIsImlzcyI6Ik15QXV0aFNlcnZlciIsImF1ZCI6Ik15QXV0aENsaWVudCJ9.bMfPi2IbAS5Fw3pnxlVanmiWxwsVTvZ6ARf3ds120wY"
        
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
            SessionStorage().sessionId = nil
            self.isAutorized = false
            self.start()
            self.remove(coordinator)
        }
        coordinator.start()
    }

}
