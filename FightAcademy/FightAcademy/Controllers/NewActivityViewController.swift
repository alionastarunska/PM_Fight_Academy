//
//  NewActivityViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol BookingNewActivity: UIViewController {

    var onSelectActivityType: (() -> Void)? { get set }
    var onSelectCoach: (() -> Void)? { get set }
    var onRequestActivity: (() -> Void)? { get set }

}

class NewActivityViewController: ViewController, BookingNewActivity {

    var onRequestActivity: (() -> Void)?
    var onSelectCoach: (() -> Void)?
    var onSelectActivityType: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "NewActivity"

        let logInButton = UIButton()
        logInButton.setTitle("ActivityType", for: .normal)
        logInButton.addTarget(self, action: #selector(chooseActivity), for: .touchUpInside)

        let regButton = UIButton()
        regButton.setTitle("Coach", for: .normal)
        regButton.addTarget(self, action: #selector(chooseCoach), for: .touchUpInside)

        let logErrButton = UIButton()
        logErrButton.setTitle("Request", for: .normal)
        logErrButton.addTarget(self, action: #selector(requestForActivity), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [logInButton, regButton, logErrButton])
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
    private func chooseActivity() {
        onSelectActivityType?()
    }

    @objc
    private func chooseCoach() {
        onSelectCoach?()
    }

    @objc
    private func requestForActivity() {
        onRequestActivity?()
    }

}
