//
//  TrailingImageTextField.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

@IBDesignable
final class TrailingImageTextField: LeadingImageTextField {

    // MARK: - Properties

    private lazy var customRightView: TextFieldRightView = {
        let view = TextFieldRightView.loadFromNib()
        return view
    }()

    var imageTapped: VoidClosure?

    @IBInspectable var trailingImageButton: UIImage? {
        didSet {
            updateTrailingIcon()
        }
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
            self?.sendActions(for: .editingChanged)
        }

        customRightView.imageForChangingTapped = { [weak self] in
            self?.imageTapped?()
        }

    }
}
