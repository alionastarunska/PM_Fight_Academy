//
//  UITextField+Inspectable.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import UIKit

extension UITextField {

    @IBInspectable
    public var placeholderColor: UIColor {
            get {
                guard let placeholderColor = attributedPlaceholder?.attribute(NSAttributedString.Key.foregroundColor,
                                                                              at: 0,
                                                                              effectiveRange: nil) as? UIColor else {
                    return UIColor.clear
                }
                return placeholderColor
            }
            set {
                guard let placeholder = attributedPlaceholder else { return }
                let attributes = [NSAttributedString.Key.foregroundColor: newValue]

                attributedPlaceholder = NSAttributedString(string: placeholder.string,
                                                           attributes: attributes)
            }
        }

}
