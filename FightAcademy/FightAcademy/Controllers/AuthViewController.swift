//
//  AuthViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

//protocol Authorization: UIViewController {
//
//    var onCompleteAuth: (() -> Void)? { get set }
//    var onSignUpButtonTap: (() -> Void)? { get set }
//    var onError: ((Error) -> Void)? { get set }
//
//}
//
//class AuthViewController: UIViewController, Authorization {
//
//    var onCompleteAuth: (() -> Void)?
//    var onSignUpButtonTap: (() -> Void)?
//    var onError: ((Error) -> Void)?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Auth"
//
//        let logInButton = UIButton()
//        logInButton.setTitle("Login", for: .normal)
//        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
//
//        let logErrButton = UIButton()
//        logErrButton.setTitle("Login error", for: .normal)
//        logErrButton.addTarget(self, action: #selector(logInError), for: .touchUpInside)
//
//        let regButton = UIButton()
//        regButton.setTitle("Reg", for: .normal)
//        regButton.addTarget(self, action: #selector(regUp), for: .touchUpInside)
//
//        let stack = UIStackView(arrangedSubviews: [logInButton, logErrButton, regButton])
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.distribution = .fillEqually
//
//        self.view.addSubview(stack)
//        stack.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        stack.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//    }
//
//    @objc
//    private func logIn() {
//        onCompleteAuth?()
//    }
//
//    private enum KekError: Error { // mock
//        case kek
//    }
//
//    @objc
//    private func logInError() {
//        onError?(KekError.kek)
//    }
//
//    @objc
//    private func regUp() {
//        onSignUpButtonTap?()
//    }
//
//}
