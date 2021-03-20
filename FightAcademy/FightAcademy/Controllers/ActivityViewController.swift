//
//  ActivityViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol Activity: UIViewController {

    var onActivityStartBooking: (() -> Void)? { get set }

}

class ActivityViewController: ViewController, Activity {

    var onActivityStartBooking: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activity"

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"),
                                                            style: UIBarButtonItem.Style.done,
                                                            target: self,
                                                            action: #selector(addActivity))

    }

    @objc
    private func addActivity() {
        onActivityStartBooking?()
    }

}
