//
//  RegisterViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

class RegisterViewController: UIViewController, NibLoadable {
    //TODO: figure out how to add a plus on keyboard o textfield in view controller

    //MARK: - Properties
    
    @IBOutlet private weak var button: DesignableButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var firstNameTextField: LeadingImageTextField!
    @IBOutlet private weak var numberTextField: LeadingImageTextField!
    @IBOutlet private weak var passwordTextField: TrailingButtonTextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
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
            let result = try validationService.validate(for: registerModel)

            guard result else { return }
            
        } catch let error {
            switch error {
            case ValidationError.badName:
                nameErrorLabel.text = ValidationError.badName.rawValue
                nameErrorLabel.isHidden = false
            case ValidationError.badPassword:
                passwordErrorLabel.text = ValidationError.badPassword.rawValue
                passwordErrorLabel.isHidden = false
            case ValidationError.badPhoneNumber:
                phoneErrorLabel.text = ValidationError.badPhoneNumber.rawValue
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
            setButtonBackground(with: UIColor(named: "customYellow"))
        } else {
            button.isEnabled = false
            setButtonBackground(with: .lightGray)
        }
    }
    
    func setButtonBackground(with color: UIColor?) {
        button.backgroundColor = color
    }
    
    
    func dismiss(_ sender:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func setTextVisibility() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.buttonClicked = { [weak self] in
            self?.passwordTextField.isSecureTextEntry.toggle()
            self?.passwordTextField.trailingImageButton = UIImage(named: "visibility")
        }
    }
}

//MARK: - UITextFieldDelegate

extension RegisterViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == numberTextField, registerModel._phoneNumber == nil {
            textField.text = symbolIntoTextField
        }
        self.activeTextField = textField
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case firstNameTextField:
            registerModel.name = firstNameTextField.text
        case numberTextField:
            registerModel.phoneNumber = numberTextField.text
        case passwordTextField:
            registerModel.password = passwordTextField.text
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
        print("textFieldShouldClear")
        return true
    }
}
