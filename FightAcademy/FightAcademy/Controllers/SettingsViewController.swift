//
//  SettingsViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol Settings: ViewController {

    var onLogOut: (() -> Void)? { get set }
    var onChangeButtonTapped: (() -> Void)? { get set }

}

class SettingsViewController: ViewController, Settings {

    var onLogOut: (() -> Void)?
    var onChangeButtonTapped: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"

        let logInButton = UIButton()
        logInButton.setTitle("Change", for: .normal)
        logInButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)

        let logErrButton = UIButton()
        logErrButton.setTitle("logout", for: .normal)
        logErrButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)

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

    @objc
    private func logOut() {
        onLogOut?()
    }

    @objc
    private func changeButtonTapped() {
        onChangeButtonTapped?()
    }

}
