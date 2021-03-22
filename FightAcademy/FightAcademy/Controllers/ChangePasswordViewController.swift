//
//  ChangePasswordViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol ChangePassword: UIViewController {

    var onError: ((Error) -> Void)? { get set }
    var onSuccess: (() -> Void)? { get set }

}

class ChangePasswordViewController: UIViewController, ChangePassword {

    var onError: ((Error) -> Void)?
    var onSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ChangePassword"

        let logInButton = UIButton()
        logInButton.setTitle("ChangeOk", for: .normal)
        logInButton.addTarget(self, action: #selector(passwordChanged), for: .touchUpInside)

        let logErrButton = UIButton()
        logErrButton.setTitle("ChangeErr", for: .normal)
        logErrButton.addTarget(self, action: #selector(gotError), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [logInButton, logErrButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually

        self.view.addSubview(stack)
        stack.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

    private enum KekError: Error { // mock
        case kek
    }

    @objc
    private func gotError() {
        onError?(KekError.kek)
    }

    @objc
    private func passwordChanged() {
        onSuccess?()
    }

}
