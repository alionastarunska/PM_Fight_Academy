//
//  ActivityCoordinatorFactory.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol ActivityFactoryProtocol {

    func makeActivityViewController() -> Activity
    func makeNewActivityViewController() -> BookingNewActivity
    func makeChooseActivityViewController() -> ChoosingActivity
    func makeChooseCoachViewController() -> ChoosingCoach
    func makeAlertController(with error: Error) -> UIAlertController

}

final class ActivityFactory: ActivityFactoryProtocol {

    func makeActivityViewController() -> Activity {
        return ActivityViewController()
    }

    func makeNewActivityViewController() -> BookingNewActivity {
        return NewActivityViewController()
    }

    func makeChooseActivityViewController() -> ChoosingActivity {
        return ChoosingActivityViewController()
    }

    func makeChooseCoachViewController() -> ChoosingCoach {
        return ChoosingCoachViewController()
    }

    func makeAlertController(with error: Error) -> UIAlertController {
        let controller = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        return controller
    }

}
