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
    func makeChooseCoachViewController(activity: TrainingType) -> ChoosingCoach
    func makeAlertController(with error: Error) -> UIAlertController

}

final class ActivityFactory: ActivityFactoryProtocol {

    func makeActivityViewController() -> Activity {
        let service = ActivityProvider(service: PMFightApi.shared)
        return ActivityViewController(activityService: service)
    }

    func makeNewActivityViewController() -> BookingNewActivity {
        return BookingActivityViewController()
    }

    func makeChooseActivityViewController() -> ChoosingActivity {
        return ChoosingActivityViewController()
    }

    func makeChooseCoachViewController(activity: TrainingType) -> ChoosingCoach {
        let vc = ChoosingCoachViewController()
        vc.activity = activity
        return vc
    }

    func makeAlertController(with error: Error) -> UIAlertController {
        let controller = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        return controller
    }

}
