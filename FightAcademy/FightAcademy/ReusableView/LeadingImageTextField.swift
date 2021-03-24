//
//  LeadingImageTextField.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

@IBDesignable
class LeadingImageTextField: UITextField {
    
    // MARK: - Properties
    
    @IBInspectable override var cornerRadius: CGFloat {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var leadingImage: UIImage? {
        didSet {
            updateLeadingImage()
        }
    }
    
    @IBInspectable var leadingText: String? {
        didSet {
            updateLeadingImage()
        }
    }
    
    @IBInspectable var leadingImageWidth: CGFloat = 0.0
    
    @IBInspectable var leadingImageHeight: CGFloat = 0.0
    
    @IBInspectable var leadingPadding: CGFloat = 0.0
    
    @IBInspectable var leadingImageColor: UIColor = UIColor.lightGray {
        //        Note: In order for your image to use the tint color,
        //        you have to select the image in the Assets.xcassets
        //        and change the "Render As" property to "Template Image".
        didSet {
            updateLeadingImage()
        }
    }
    
    // MARK: - Ovveride methods
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leadingPadding
        return textRect
    }
    
    // MARK: - Handlers
    
    private func updateCornerRadius(using cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
    }
    
    private func updateLeadingImage() {
        if let image = leadingImage {
            
            leftViewMode = UITextField.ViewMode.always
            
            let imageView = UIImageView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: leadingImageWidth,
                                                      height: leadingImageHeight))
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = leadingImageColor
            
            leftView = imageView
            
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
}
