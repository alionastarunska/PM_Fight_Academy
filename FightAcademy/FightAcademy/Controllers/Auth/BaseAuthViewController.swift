//
//  BaseAuthViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 23.03.2021.
//

import UIKit

class BaseAuthViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet internal weak var doneButton: DesignableButton!
    @IBOutlet internal weak var scrollView: UIScrollView!
    @IBOutlet internal weak var phoneTextField: LeadingImageTextField!
    @IBOutlet internal weak var passwordTextField: TrailingImageTextField!
    @IBOutlet internal weak var phoneErrorLabel: UILabel!
    @IBOutlet internal weak var passwordErrorLabel: UILabel!
    
    internal let symbolIntoTextField = "+"
    internal var activeTextField: UITextField?

    internal var validationService: Validating?
    internal var authService: AuthorizationService?

    var onCompleteAuth: (() -> Void)?
    var onError: ((Error) -> Void)?
    
}

extension BaseAuthViewController {
    
    // MARK: - Handlers
    
    func setTextVisibility() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.imageTapped = { [weak self] in
            guard let self = self else { return }
            if self.passwordTextField.isSecureTextEntry {
                self.passwordTextField.trailingImageButton = UIImage(systemName: "eye.slash.fill")
            } else {
                self.passwordTextField.trailingImageButton = UIImage(systemName: "eye.fill")
            }
            self.passwordTextField.isSecureTextEntry.toggle()
        }
    }
    
    func setKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func setClearButtons(for textfields: [LeadingImageTextField], image: UIImage?) {
        guard let image = image else { return }
        
        textfields.forEach {
            $0.setCustomClearButton(with: image)
        }
    }
}
