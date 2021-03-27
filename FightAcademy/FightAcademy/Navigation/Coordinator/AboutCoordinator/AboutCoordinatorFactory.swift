//
//  AboutCoordinatorFactory.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol AboutFactoryProtocol {

    func makeAboutViewController() -> UIViewController

}

final class AboutFactory: AboutFactoryProtocol {

    func makeAboutViewController() -> UIViewController {
        return AboutViewController()
    }

}
