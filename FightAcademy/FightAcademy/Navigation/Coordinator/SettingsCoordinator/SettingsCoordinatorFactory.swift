//
//  SettingsCoordinatorFactory.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol SettingsFactoryProtocol {

    func makeSettingsViewController() -> Settings
    func makeAlertController(with error: Error) -> UIAlertController

}

final class SettingsFactory: SettingsFactoryProtocol {

    func makeSettingsViewController() -> Settings {
        return SettingsViewController()
    }

    func makeAlertController(with error: Error) -> UIAlertController {
        let controller = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        return controller
    }

}
