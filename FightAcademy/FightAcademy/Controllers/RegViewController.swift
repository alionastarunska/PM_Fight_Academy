//
//  RegViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

//protocol Registering: UIViewController {
//
//    var onCompleteAuth: (() -> Void)? { get set }
//    var onError: ((Error) -> Void)? { get set }
//
//}

//class RegistrationViewController: UIViewController, Registering {
//
//    var onCompleteAuth: (() -> Void)?
//    var onError: ((Error) -> Void)?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Registration"
//
//        let logInButton = UIButton()
//        logInButton.setTitle("Reg Ok", for: .normal)
//        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
//
//        let regButton = UIButton()
//        regButton.setTitle("RegError", for: .normal)
//        regButton.addTarget(self, action: #selector(regError), for: .touchUpInside)
//
//        let stack = UIStackView(arrangedSubviews: [logInButton, regButton])
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
//    private func regError() {
//        onError?(KekError.kek)
//    }
//
//}
