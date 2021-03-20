//
//  Router.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

final class Router: RouterProtocol {

    private weak var rootController: UINavigationController?

    init(rootController: UINavigationController) {
        self.rootController = rootController
    }

    func routingController() -> UIViewController? {
        return rootController
    }

    func popToRoot(animated: Bool) {
        _ = rootController?.popToRootViewController(animated: animated)
    }

    func setNewRoot(_ controller: Routed?, animated: Bool, hideBar: Bool) {
        guard let controller = controller?.routingController() else { return }
        rootController?.setViewControllers([controller], animated: true)
        rootController?.isNavigationBarHidden = hideBar
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    func pop(animated: Bool) {
        _ = rootController?.popViewController(animated: animated)
    }

    func present(_ controller: Routed?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = controller?.routingController() else { return }
        rootController?.present(controller, animated: animated, completion: completion)
    }

    func push(_ controller: Routed?, animated: Bool, hideBottomBar: Bool) {
        guard let controller = controller?.routingController() else { return }
        guard controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }

}
