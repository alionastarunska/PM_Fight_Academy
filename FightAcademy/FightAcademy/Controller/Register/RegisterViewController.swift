//
//  RegisterViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

class RegisterViewController: BaseAuthViewController, NibLoadable {
    //MARK: - Properties
   
    @IBOutlet private weak var firstNameTextField: LeadingImageTextField!
    @IBOutlet private weak var nameErrorLabel: UILabel!

    private var registerModel = RegisterModel()
           
    init(validationService: Validating, authService: AuthorizationService) {
        super.init(nibName: RegisterViewController.name, bundle: .main)
        self.validationService = validationService
        self.authService = authService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setErrorsLabelHiden()
        
        setClearButtonsMode(for: [firstNameTextField, phoneTextField])
        
        checkButtonAvailability()
        
        setTextVisibility()
        
        setTextFieldDelegating()
        
        setKeyboardObservers()
    }
    
    //MARK: - IBAction
    
    @IBAction func signUpAction(_ sender: Any) {
        
        do {
            try validationService?.validate(for: registerModel)
            authService?.authorize(with: registerModel) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    self.onCompleteAuth?()
                case .failure(let error):
                    self.onError?(error)
                }
            }
            print("Registration done")
        } catch let error {
            switch error {
            case ValidationError.badName(let message):
                nameErrorLabel.text = message
                nameErrorLabel.isHidden = false
            case ValidationError.badPassword(let message):
                passwordErrorLabel.text = message
                passwordErrorLabel.isHidden = false
            case ValidationError.badPhoneNumber(let message):
                phoneErrorLabel.text = message
                phoneErrorLabel.isHidden = false
            default:
                return
            }
        }
    }
    
}


private extension RegisterViewController {
    
    //MARK: - Methods
    
    private func setErrorsLabelHiden() {
        nameErrorLabel.isHidden = true
        phoneErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    

    
    private func setTextFieldDelegating() {
        firstNameTextField.delegate = self
        phoneTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    func checkButtonAvailability() {
        if registerModel.isFilled {
            doneButton.isEnabled = true
            doneButton.backgroundColor = UIColor(named: "customYellow")
        } else {
            doneButton.isEnabled = false
            doneButton.backgroundColor = .lightGray
        }
    }
    
    func dismiss(_ sender:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

//MARK: - UITextFieldDelegate

extension RegisterViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTextField, registerModel.phoneNumber == nil {
            textField.text = symbolIntoTextField
        }
        self.activeTextField = textField
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case firstNameTextField:
            registerModel.name = firstNameTextField.text
            nameErrorLabel.isHidden = true
        case phoneTextField:
            registerModel.phoneNumber = phoneTextField.text
            phoneErrorLabel.isHidden = true
        case passwordTextField:
            registerModel.password = passwordTextField.text
            passwordErrorLabel.isHidden = true
        default:
            break
        }
        checkButtonAvailability()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        checkButtonAvailability()
        return true
    }
}
