//
//  RegisterViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

class RegisterViewController: UIViewController, NibLoadable {
    @IBOutlet weak var button: DesignableButton!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var firstNameTextField: LeadingImageTextField!
    
    @IBOutlet private weak var numberTextField: LeadingImageTextField!
    
    @IBOutlet weak var passwordTextField: TrailingButtonTextField!
    
    var activeTextField : UITextField? = nil

    //TODO: think about provider for that???
    private var registerData = RegisterData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkButtonAvailability()
        
        setTextVisibility()
        
        setTextFieldDelegating()
        
        setKeyboardObservers()
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
      }

      @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        
        // reset back the content inset to zero after keyboard is gone
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
      }
    
    private func setTextFieldDelegating() {
        firstNameTextField.delegate = self
        numberTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        print("register action")
    }
    
    @IBAction func firstNameEditingDidChange(_ sender: UITextField) {
        print("First name typing ended")
        registerData.name = sender.text
        checkButtonAvailability()
    }
    
    @IBAction func phoneNumberEditingDidChange(_ sender: UITextField) {
        print("First name typing ended")
        registerData.phoneNumber = sender.text
        checkButtonAvailability()

    }
    
    @IBAction func passwordEditingDidChange(_ sender: UITextField) {
        print("passwordEditingDidChange")
        registerData.password = sender.text
        checkButtonAvailability()


    }
    
    private func checkButtonAvailability() {
//        if registerData.isFilled {
//            button.isEnabled = true
//        }else {
//            button.isEnabled = false
//        }
    }

}


private extension RegisterViewController {
    func setTextVisibility() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.buttonClicked = { [weak self] in
            self?.passwordTextField.isSecureTextEntry.toggle()
        }
    }
}

extension RegisterViewController : UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.activeTextField = textField
  }
    
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.activeTextField = nil
  }
}
