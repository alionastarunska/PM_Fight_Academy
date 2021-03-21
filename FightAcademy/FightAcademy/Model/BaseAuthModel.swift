//
//  BaseAuthModel.swift
//  FightAcademy
//
//  Created by Павел Снижко on 21.03.2021.
//

import Foundation


class BaseAuthModel: Codable {
    var _phoneNumber: String?
    var password: String?
    
    init() {}
    
    var phoneNumber: String? {
        set {
            if let newValue = newValue {
                _phoneNumber = "+" + newValue
            }
        }
        
        get {
            _phoneNumber
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case _phoneNumber = "login"
        case password
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _phoneNumber = try container.decode(String?.self, forKey: ._phoneNumber)
        password = try container.decode(String?.self, forKey: .password)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(_phoneNumber, forKey: ._phoneNumber)
        try container.encode(password, forKey: .password)
        
    }
}
