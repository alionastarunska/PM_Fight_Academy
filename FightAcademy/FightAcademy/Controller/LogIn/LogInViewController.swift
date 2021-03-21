//
//  LogInViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 19.03.2021.
//

import UIKit

class LogInViewController: UIViewController, NibLoadable {

    override func viewDidLoad() {
        super.viewDidLoad()
        let encoder = JSONEncoder()

        let model = AuthModel()
        model.phoneNumber = nil
        model.password = "fsdfssf"
    
        
        
        let data = try? encoder.encode(model)
        print(String(decoding: data!, as: UTF8.self))
        // Do any additional setup after loading the view.
    }
}
