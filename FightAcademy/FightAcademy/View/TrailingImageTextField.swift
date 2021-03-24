//
//  TrailingImageTextField.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

@IBDesignable
class TrailingImageTextField: LeadingImageTextField {
    
    // MARK: - Properties
    
    private lazy var customRightView: CustomRightView = {
        let view = CustomRightView.loadFromNib()
        return view
    }()
    
    var imageTapped: VoidClosure?
    
    @IBInspectable var trailingPadding: CGFloat = 0
    
    @IBInspectable var trailingImageButton: UIImage? {
        didSet {
            updateTrailingIcon()
        }
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += trailingPadding
        return rect
    }
    
    // MARK: - Handlers
    
    private func updateTrailingIcon() {
        if let image = trailingImageButton {
            
            customRightView.setImage(with: image)
            setHandlersForImageTapping()
            
            self.rightView = customRightView
            rightViewMode = .whileEditing

        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
    }
    
    private func setHandlersForImageTapping() {
        customRightView.cleanIconTapped = { [weak self] in
            self?.text = nil
        }
        customRightView.imageForChangingTapped = { [weak self] in
            self?.imageTapped?()
        }
        
    }
}
