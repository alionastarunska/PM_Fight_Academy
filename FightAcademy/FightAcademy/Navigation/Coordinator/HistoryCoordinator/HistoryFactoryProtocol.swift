//
//  HistoryFactoryProtocol.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol HistoryFactoryProtocol {

    func makeHistoryViewController() -> UIViewController

}

final class HistoryFactory: HistoryFactoryProtocol {

    func makeHistoryViewController() -> UIViewController {
        return HistoryViewController()
    }

}
