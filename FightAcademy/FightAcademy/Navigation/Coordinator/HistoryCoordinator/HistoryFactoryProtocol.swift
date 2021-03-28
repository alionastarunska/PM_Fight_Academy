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
        let service = HistoryProvider(service: PMFightApi.shared)
        return HistoryViewController(historyService: service)
    }

}
