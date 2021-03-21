//
//  CoachesCoordinatorFactory.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol CoachesFactoryProtocol {

    func makeCoachesViewController() -> UIViewController
}

final class CoachesFactory: CoachesFactoryProtocol {

    func makeCoachesViewController() -> UIViewController {
        return CoachViewController()
    }

}
