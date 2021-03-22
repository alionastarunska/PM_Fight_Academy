//
//  LogInViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

class LogInViewController: UIViewController, NibLoadable {
    
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var phoneTextField: LeadingImageTextField!
    @IBOutlet private weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var doneButton: DesignableButton!
    //TODO: move to constant
    private let symbolIntoTextField = "+"
    
    private var activeTextField : UITextField?
    
    //TODO: make refactore when create custom UIViewController with scroll view and hide keyboard
    
    @IBOutlet private weak var passwordTextField: TrailingButtonTextField!
    @IBOutlet private weak var passwordErrorLabel: UILabel!
    
    var onCompleteAuth: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    private var authModel = AuthModel()
    
    private var validationService: ValidationService
    private var authService: AuthorizationService
    
    init(validationService: ValidationService, authService: AuthorizationService) {
        self.validationService = validationService
        self.authService = authService
        
        super.init(nibName: LogInViewController.name, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
    @IBAction func logInPressed(_ sender: Any) {
        do {
            try validationService.validate(for: authModel)
            authService.authorize(with: authModel) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    self.onCompleteAuth?()
                case .failure(let error):
                    self.onError?(error)
                }
            }
            print("Login done")
        } catch _ {
            passwordErrorLabel.text = ValidationError.Contnet.unknown
            passwordErrorLabel.isHidden = false
            }
        }
    
    @IBAction func createAccountPressed(_ sender: Any) {
    }
}

extension LogInViewController {
    private func setErrorsLabelHiden() {
        phoneErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
    private func setClearButtons() {
        //TODO: Figure out how to add both clear and hide buttons for password
        passwordTextField.clearButtonMode = .whileEditing
        phoneTextField.clearButtonMode = .whileEditing
    }

    
    private func setTextFieldDelegating() {
        phoneTextField.delegate = self
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
        if authModel.isFilled {
            doneButton.isEnabled = true
            doneButton.backgroundColor = UIColor(named: "customYellow")
        } else {
            doneButton.isEnabled = false
            doneButton.backgroundColor = .lightGray
        }
    }
    
    func setButtonBackground(with color: UIColor?) {
        doneButton.backgroundColor = color
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

extension LogInViewController : UITextFieldDelegate {
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
