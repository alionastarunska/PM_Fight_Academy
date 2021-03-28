//
//  RegisterViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

protocol Registering: UIViewController {

    var onCompleteAuth: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }

}

final class RegisterViewController<RegValidator: RegistrationValidationService>: BaseAuthViewController,
                                                                                 NibLoadable,
                                                                                 Registering,
                                                                                 UITextFieldDelegate {
    // MARK: - Properties

    @IBOutlet private weak var firstNameTextField: LeadingImageTextField!
    @IBOutlet private weak var nameErrorLabel: UILabel!
    private var validationService: RegistrationValidator<RegValidator>
    private var registerModel = RegValidator.CustomRegistraionModel()
    private var authService: AuthorizationService

    init(validationService: RegistrationValidator<RegValidator>, authService: AuthorizationService) {
        self.validationService = validationService
        self.authService = authService
        super.init(nibName: Self.name, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()

        setErrorsLabelHiden()

        setClearButtons(for: [firstNameTextField, phoneTextField],
                        image: UIImage(systemName: "multiply.circle.fill"))

        checkButtonAvailability()

        setTextVisibility()

        setTextFieldDelegating()

        setKeyboardObservers()
    }

    // MARK: - IBAction

    @IBAction func signUpAction(_ sender: Any) {
        self.setButtonNotEnabling(doneButton)
        do {

            try validationService.validate(registerModel)
            self.startLoading()
            authService.registrate(phone: registerModel.phone,
                             password: registerModel.password,
                             name: registerModel.name,
                             completion: { [weak self] (error) in
                              guard let self = self else {
                                  return
                              }
                                self.endLoading()
                              switch error {
                              case .none:
                                  self.onCompleteAuth?()
                              case .some(let error):
                                  self.onError?(error)
                              }
                             })
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

// MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === phoneTextField {
            textField.text = symbolIntoTextField
        }
        self.activeTextField = textField
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkButtonAvailability()
        guard let name = firstNameTextField.text,
              let phone = phoneTextField.text,
              let password = passwordTextField.text else {
            return
        }
        switch textField {
        case firstNameTextField:
            registerModel.name = name
            nameErrorLabel.isHidden = true
        case phoneTextField:
            registerModel.phone = phone
            phoneErrorLabel.isHidden = true
        case passwordTextField:
            registerModel.password = password
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

extension RegisterViewController {

    func setErrorsLabelHiden() {
        nameErrorLabel.isHidden = true
        phoneErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }

    func setTextFieldDelegating() {
        firstNameTextField.delegate = self
        phoneTextField.delegate = self
        passwordTextField.delegate = self
    }

    func checkButtonAvailability() {
        if registerModel.isFilled {
            self.setButtonEnabling(doneButton)
        } else {
            self.setButtonNotEnabling(doneButton)
        }
    }

    func dismiss(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

}
