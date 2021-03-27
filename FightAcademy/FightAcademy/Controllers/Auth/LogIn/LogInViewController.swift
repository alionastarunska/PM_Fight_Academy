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

class LogInViewController<LoginValidator: LogginingValidationService>: BaseAuthViewController,
                                                                       NibLoadable,
                                                                       Authorization,
                                                                       UITextFieldDelegate {

    var onSignUpButtonTap: (() -> Void)?
    private var authModel = LoginValidator.CustomLoginModel(password: "PaSSw0rd123", phone: "+380689292193")
    private var validationService: LogginingValidator<LoginValidator>
    private var authService: AuthorizationService

    init(validationService: LogginingValidator<LoginValidator>, authService: AuthorizationService) {
        self.authService = authService
        self.validationService = validationService
        super.init(nibName: Self.name, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setErrorsLabelHiden()

        setClearButtons(for: [phoneTextField],
                        image: UIImage(systemName: "multiply.circle.fill"))

        checkButtonAvailability()

        setTextVisibility()

        setTextFieldDelegating()

        setKeyboardObservers()
    }

    // MARK: - IBAction
    @IBAction func logInPressed(_ sender: Any) {
        do {

            try validationService.validate(authModel)
            authService.logIn(phone: authModel.phone,
                               password: authModel.password,
                               completion: { [weak self] (error) in
                                guard let self = self else {
                                    return
                                }
                                switch error {
                                case .none:
                                    self.onCompleteAuth?()
                                case .some(let error):
                                    self.onError?(error)
                                }
                               })
        } catch _ {
            passwordErrorLabel.text = ValidationError.Content.unknown
            passwordErrorLabel.isHidden = false
        }
    }

    @IBAction func createAccountPressed(_ sender: Any) {
        onSignUpButtonTap?()
    }

// MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === phoneTextField {
            textField.text = symbolIntoTextField
        }
        self.activeTextField = textField
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkButtonAvailability()
        guard let phone = phoneTextField.text,
              let password = passwordTextField.text else {
            return
        }
        switch textField {
        case phoneTextField:
            authModel.phone = phone
            phoneErrorLabel.isHidden = true
        case passwordTextField:
            authModel.password = password
            passwordErrorLabel.isHidden = true
        default:
            break
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        checkButtonAvailability()
        return true
    }

}

// MARK: - Private Methods

private extension LogInViewController {

    func setErrorsLabelHiden() {
        phoneErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }

    func setTextFieldDelegating() {
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
