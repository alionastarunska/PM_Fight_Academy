//
//  RegisterViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

class RegisterViewController: UIViewController, NibLoadable {
    //MARK: - Properties
    
    @IBOutlet private weak var button: DesignableButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var firstNameTextField: LeadingImageTextField!
    @IBOutlet private weak var numberTextField: LeadingImageTextField!
    @IBOutlet private weak var passwordTextField: TrailingButtonTextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    var onCompleteAuth: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    private var activeTextField : UITextField?
    
    private let symbolIntoTextField = "+"
    
    private var registerModel = RegisterModel()
    
    //TODO: CHANGE TO PROTOCOL
    private var validationService: ValidationService
    private var authService: AuthorizationService
    
    init(validationService: ValidationService, authService: AuthorizationService) {
        self.validationService = validationService
        self.authService = authService
        
        super.init(nibName: RegisterViewController.name, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setErrorsLabelHiden()
        
        setClearButtons()
        
        checkButtonAvailability()
        
        setTextVisibility()
        
        setTextFieldDelegating()
        
        setKeyboardObservers()
    }
    
    //MARK: - IBAction
    
    @IBAction func signUpAction(_ sender: Any) {
        
        do {
            try validationService.validate(for: registerModel)
            authService.authorize(with: registerModel) { [weak self] result in
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
    
    private func setClearButtons() {
        //TODO: Figure out how to add both clear and hide buttons for password
//        passwordTextField.clearButtonMode = .whileEditing
        firstNameTextField.clearButtonMode = .whileEditing
        numberTextField.clearButtonMode = .whileEditing
    }

    
    private func setTextFieldDelegating() {
        firstNameTextField.delegate = self
        numberTextField.delegate = self
        passwordTextField.delegate = self
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
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func checkButtonAvailability() {
        if registerModel.isFilled {
            button.isEnabled = true
            button.backgroundColor = UIColor(named: "customYellow")
        } else {
            button.isEnabled = false
            button.backgroundColor = .lightGray
        }
    }
    
    func dismiss(_ sender:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func setTextVisibility() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.buttonClicked = { [weak self] in
            self?.passwordTextField.isSecureTextEntry.toggle()
            self?.passwordTextField.trailingImageButton = UIImage(systemName: "eye.slash.fill")
        }
    }
}

//MARK: - UITextFieldDelegate

extension RegisterViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == numberTextField, registerModel.phoneNumber == nil {
            textField.text = symbolIntoTextField
        }
        self.activeTextField = textField
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case firstNameTextField:
            registerModel.name = firstNameTextField.text
            nameErrorLabel.isHidden = true
        case numberTextField:
            registerModel.phoneNumber = numberTextField.text
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
