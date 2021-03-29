//
//  LogInService.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

protocol LogInService {

    func logIn(phone: String, password: String, completion: @escaping (Error?) -> Void)

}
