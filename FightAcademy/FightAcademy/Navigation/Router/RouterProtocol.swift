//
//  RouterProtocol.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import Foundation

protocol RouterProtocol: Routed {

    func present(_ controller: Routed?)
    func present(_ controller: Routed?, animated: Bool)
    func present(_ controller: Routed?, animated: Bool, completion: (() -> Void)?)

    func push(_ controller: Routed?)
    func push(_ controller: Routed?, hideBottomBar: Bool)
    func push(_ controller: Routed?, animated: Bool)
    func push(_ controller: Routed?, animated: Bool, hideBottomBar: Bool)

    func pop()
    func pop(animated: Bool)

    func dismiss()
    func dismiss(animated: Bool, completion: (() -> Void)?)

    func setNewRoot(_ controller: Routed?)
    func setNewRoot(_ controller: Routed?, animated: Bool)
    func setNewRoot(_ controller: Routed?, hideBar: Bool)
    func setNewRoot(_ controller: Routed?, animated: Bool, hideBar: Bool)

    func popToRoot()
    func popToRoot(animated: Bool)

}

extension RouterProtocol {

    func popToRoot() {
        pop(animated: true)
    }

}

extension RouterProtocol {

    func setNewRoot(_ controller: Routed?) {
        setNewRoot(controller, animated: true)
    }

    func setNewRoot(_ controller: Routed?, animated: Bool) {
        setNewRoot(controller, animated: animated, hideBar: false)
    }

    func setNewRoot(_ controller: Routed?, hideBar: Bool) {
        setNewRoot(controller, animated: true, hideBar: hideBar)
    }

}

extension RouterProtocol {

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }

}

extension RouterProtocol {

    func pop() {
        pop(animated: true)
    }

}

extension RouterProtocol {

    func present(_ controller: Routed?) {
        present(controller, animated: true)
    }

    func present(_ controller: Routed?, animated: Bool) {
        present(controller, animated: animated, completion: nil)
    }

}

extension RouterProtocol {

    func push(_ controller: Routed?) {
        push(controller, animated: true)
    }

    func push(_ controller: Routed?, hideBottomBar: Bool) {
        push(controller, animated: true, hideBottomBar: hideBottomBar)
    }

    func push(_ controller: Routed?, animated: Bool) {
        push(controller, animated: animated, hideBottomBar: false)
    }

}
