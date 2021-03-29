//
//  UIView+Shake.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 25.03.2021.
//

import UIKit

extension UIView {

    func center(in bounds: CGRect) {
        frame.origin.x = max(0, (bounds.size.width - frame.size.width) * 0.5)
        frame.origin.y = max(0, (bounds.size.height - frame.size.height) * 0.5)
    }

    func shake(count: Float = 4, offset: CGFloat = 10.0) {

        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = count
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - offset, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + offset, y: center.y))

        layer.add(animation, forKey: "position")
    }

}
