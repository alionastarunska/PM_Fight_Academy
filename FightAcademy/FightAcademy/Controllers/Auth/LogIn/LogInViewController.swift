//
//  LogInViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

protocol Authorization: UIViewController {
    
    var onCompleteAuth: (() -> Void)? { get set }
    var onSignUpButtonTap: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    
}

class LogInViewController: BaseAuthViewController, NibLoadable, Authorization {
    
    var onSignUpButtonTap: (() -> Void)?
    private var authModel = AuthorizationModel()
    
    init(validationService: Validating, authService: AuthorizationService) {
        super.init(nibName: LogInViewController.name, bundle: .main)
        self.validationService = validationService
        self.authService = authService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setErrorsLabelHiden()
        
        setClearButtonsMode(for: [phoneTextField])
        
        checkButtonAvailability()
        
        setTextVisibility()
        
        setTextFieldDelegating()
        
        setKeyboardObservers()
    }
    
    // MARK: - IBAction
    @IBAction func logInPressed(_ sender: Any) {
        do {
            try validationService?.validate(for: authModel)
            authService?.authorize(with: authModel) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.onCompleteAuth?()
                case .failure(let error):
                    self.onError?(error)
                }
            }
            print("done")
        } catch _ {
            passwordErrorLabel.text = ValidationError.Contnet.unknown
            passwordErrorLabel.isHidden = false
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        onSignUpButtonTap?()
    }
}

extension LogInViewController {
    
    private func setErrorsLabelHiden() {
        phoneErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
    private func setTextFieldDelegating() {
        phoneTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func checkButtonAvailability() {
        if authModel.isFilled {
            doneButton.isEnabled = true
            doneButton.backgroundColor = UIColor(named: "customYellow")
        } else {
            doneButton.isEnabled = false
            doneButton.backgroundColor = .lightGray
        }
    }
    
    func dismiss(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTextField, authModel.phoneNumber == nil {
            textField.text = symbolIntoTextField
        }
        self.activeTextField = textField
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case phoneTextField:
            authModel.phoneNumber = phoneTextField.text
            phoneErrorLabel.isHidden = true
        case passwordTextField:
            authModel.password = passwordTextField.text
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
