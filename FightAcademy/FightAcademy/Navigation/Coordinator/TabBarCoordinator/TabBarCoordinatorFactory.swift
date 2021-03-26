//
//  TabBarCoordinatorFactory.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol TabBarFactoryProtocol {

    func makeTabBarController() -> UITabBarController
    func makeTabBarPages() -> [(nc: NavigationController, coord: FinishFlowCoordinator)]

}

final class TabBarFactory: TabBarFactoryProtocol {

    private func navigationController(for page: TabBarPage) -> NavigationController {
        let navigationController = NavigationController()
        navigationController.tabBarItem = UITabBarItem(title: page.pageName,
                                                       image: UIImage(named: page.image),
                                                       tag: page.tag)

        return navigationController
    }

    func makeTabBarController() -> UITabBarController {
        let tabBatController = TabBarController()
        return tabBatController
    }

    func makeTabBarPages() -> [(nc: NavigationController, coord: FinishFlowCoordinator)] {

        let pages: [(NavigationController, FinishFlowCoordinator)] = TabBarPage.allCases.map {

            let navigationController = self.navigationController(for: $0)
            let router = Router(rootController: navigationController)
            let coordinator = $0.pageCoordinator.init(router: router)
            
            return (navigationController, coordinator)

        }

        return pages

    }

    private enum TabBarPage: CaseIterable {

        case main
        case coachList
        case activity
        case history
        case settings

        var pageName: String {
            switch self {
            case .main:
                return "About"
            case .coachList:
                return "Coaches"
            case .activity:
                return "Activity"
            case .history:
                return "History"
            case .settings:
                return "Settings"
            }
        }

        var tag: Int {
            switch self {
            case .main:
                return 0
            case .coachList:
                return 1
            case .activity:
                return 2
            case .history:
                return 3
            case .settings:
                return 4
            }
        }

        var image: String {
            switch self {
            case .main:
                return "main"
            case .coachList:
                return "coaches"
            case .activity:
                return "activity"
            case .history:
                return "history"
            case .settings:
                return "settings"
            }
        }

        var pageCoordinator: FinishFlowCoordinator.Type {
            switch self {
            case .main:
                return AboutCoordinator.self
            case .coachList:
                return CoachesCoordinator.self
            case .activity:
                return ActivityCoordinator.self
            case .history:
                return HistoryCoordinator.self
            case .settings:
                return SettingsCoordinator.self
            }
        }

    }

}
