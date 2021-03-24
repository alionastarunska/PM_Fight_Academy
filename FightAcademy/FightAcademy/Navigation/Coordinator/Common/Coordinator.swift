//
//  Coordinator.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

protocol Coordinator: class {

    var childCoordinators: [Coordinator] { get }
    func start()

}
