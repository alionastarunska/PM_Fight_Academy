//
//  UINavigationBar.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import UIKit

extension UINavigationBar {

    static func configure() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }

}
