//
//  Routed.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol Routed {

    func routingController() -> UIViewController?

}

extension UIViewController: Routed {

    func routingController() -> UIViewController? {
        return self
    }

}
