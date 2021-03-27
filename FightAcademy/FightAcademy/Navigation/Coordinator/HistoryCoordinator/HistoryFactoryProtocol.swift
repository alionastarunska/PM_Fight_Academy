//
//  HistoryFactoryProtocol.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol HistoryFactoryProtocol {

    func makeHistoryViewController() -> HistoryViewController

}

final class HistoryFactory: HistoryFactoryProtocol {

    func makeHistoryViewController() -> HistoryViewController {
        return HistoryViewController(nibName: HistoryViewController.name, bundle: .main)
    }

}
