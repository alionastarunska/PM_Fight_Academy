//
//  NavigationController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

class NavigationController: UINavigationController {

    private let barBackgrounColor: UIColor = .black
    private let barTintColor: UIColor = .systemYellow
    private let barFont: UIFont = UIFont(name: "Georgia", size: 18)!.bold()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        navigationBar.barStyle = UIBarStyle.black

        navigationBar.barTintColor = barBackgrounColor

        navigationBar.tintColor = barTintColor

        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: barFont,
                                             NSAttributedString.Key.foregroundColor: barTintColor]

    }

}

extension NavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }

}
