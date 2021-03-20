//
//  ChoosingCoachViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol ChoosingCoach: UIViewController {

    var onSelectCoach: (() -> Void)? { get set }

}

class ChoosingCoachViewController: ViewController, ChoosingCoach {

    var onSelectCoach: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Coaches"

        let logInButton = UIButton()
        logInButton.setTitle("Choose", for: .normal)
        logInButton.addTarget(self, action: #selector(chooseActivity), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [logInButton])
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
        onSelectCoach?()
    }

}
