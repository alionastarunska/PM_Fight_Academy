//
//  BaseAuthModel.swift
//  FightAcademy
//
//  Created by Павел Снижко on 21.03.2021.
//

import Foundation

// TODO: не должно быть опшыонал
// спробувати імплементувати через protocol BaseAuthModel: Codable
class BaseAuthModel: Codable {
    var phoneNumber: String?
    var password: String?
    
    init() {}
    
    private enum CodingKeys: String, CodingKey {
        case phoneNumber = "login"
        case password
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        phoneNumber = try container.decode(String?.self, forKey: .phoneNumber)
        password = try container.decode(String?.self, forKey: .password)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(password, forKey: .password)
        
    }
}
