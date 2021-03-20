//
//  DesignableButton.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
    
    //MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
