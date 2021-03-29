//
//  TabBarController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    func setUp() {

        tabBar.barStyle = .black
        tabBar.barTintColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        tabBar.tintColor = UIColor.systemYellow

    }

}
