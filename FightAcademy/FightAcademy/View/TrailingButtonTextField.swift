//
//  TrailingButtonTextField.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

@IBDesignable
class TrailingButtonTextField: LeadingImageTextField {
    
    //MARK: - Properties
    
    var buttonClicked: VoidClosure?
    
    let button = UIButton(type: .custom)

    @IBInspectable var trailingButtonWidth: CGFloat = 0
    
    @IBInspectable var trailingButtonHeight: CGFloat = 0
    
    @IBInspectable var trailingPadding: CGFloat = 0
    
    @IBInspectable var trailingImageButton: UIImage? {
        didSet {
            updateTrailingButton()
        }
    }
    
    @IBInspectable var trailingImageButtonColor: UIColor = UIColor.white {
        // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
        didSet {
            updateTrailingButton()
        }
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += trailingPadding
        return textRect
    }
    
    
    private func updateTrailingButton() {
        if let image = trailingImageButton {
            
            rightViewMode = UITextField.ViewMode.always
            
            button.frame = CGRect(x:0,
                                  y:0,
                                  width: trailingButtonWidth,
                                  height: trailingButtonHeight)
            
            button.setImage(image , for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tintColor = trailingImageButtonColor
            button.addTarget(self, action: #selector(clickedButton), for: .touchUpInside)
            
            rightView = button
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
    }
    
    @objc func clickedButton() {
        buttonClicked?()
        print("works")
    }
    
    
}
