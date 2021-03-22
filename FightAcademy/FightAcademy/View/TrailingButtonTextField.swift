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
    
    private let button = UIButton(type: .custom)

    @IBInspectable var trailingButtonWidth: CGFloat = 10
    
    @IBInspectable var rightViewWidth: CGFloat = 40
    
    @IBInspectable var rightViewHeight: CGFloat = 40

    @IBInspectable var trailingButtonHeight: CGFloat = 10
    
    @IBInspectable var trailingPadding: CGFloat = 0
    
    @IBInspectable var trailingImageButton: UIImage? {
        didSet {
            updateTrailingIcons()
        }
    }
    
    @IBInspectable var trailingImageButtonColor: UIColor = UIColor.white {
        // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
        didSet {
            updateTrailingIcons()
        }
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += trailingPadding
        
        let customRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: 40, height: 10)
        return customRect
    }
    
    
    private func updateTrailingIcons() {
        if let image = trailingImageButton {
            
            rightViewMode = UITextField.ViewMode.whileEditing
            
            button.frame = CGRect(x: 0,
                                  y: 0,
                                  width: trailingButtonWidth,
                                  height: trailingButtonHeight)
            button.setImage(image , for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tintColor = trailingImageButtonColor
            button.addTarget(self, action: #selector(clickedButton), for: .touchUpInside)
            
            let stack = UIStackView()
            stack.axis = .horizontal
            
            let cleanIcon = setCleanIcon()
            
            stack.addArrangedSubview(cleanIcon)
            stack.addArrangedSubview(button)
            stack.spacing = 6
            stack.alignment = .center
            rightView = stack
            
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
    }
    
    private func setCleanIcon() -> UIImageView {
        let cleanIcon =  UIImageView(image: UIImage(systemName: "multiply.circle.fill"))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(cleanIconTapped(tapGestureRecognizer:)))
        cleanIcon.isUserInteractionEnabled = true
        cleanIcon.addGestureRecognizer(tapGestureRecognizer)
        
        cleanIcon.tintColor = UIColor.lightGray
        
        return cleanIcon
    }
    
    @objc func cleanIconTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.text = nil
    }
    
    @objc func clickedButton() {
        buttonClicked?()
    }
}
