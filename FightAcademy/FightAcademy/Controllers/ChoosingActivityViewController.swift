//
//  ChoosingActivityViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol ChoosingActivity: UIViewController {

    var onSelectActivityType: (() -> Void)? { get set }

}

class ChoosingActivityViewController: UIViewController, ChoosingActivity {

    var onSelectActivityType: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activity"

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
        onSelectActivityType?()
    }

}
