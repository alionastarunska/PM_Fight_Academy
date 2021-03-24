//
//  RegistrationModel.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation

class RegistrationModel: BaseAuthModel {
    var firstName: String?
  
    var name: String? {
        get {
            firstName
        }
        
        set {
            if let newValue = newValue {
                firstName = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
    
    var isFilled: Bool {
        !(firstName ?? "").isEmpty && !(phoneNumber ?? "").isEmpty && !(password ?? "").isEmpty
    }
    
    override init() { super.init() }
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "name"

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName = try container.decode(String?.self, forKey: .firstName)
        
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .firstName)
    }
}
