//
//  RegisterData.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation

class RegisterModel: BaseAuthModel {
    var _name: String?
  
    var name: String? {
        set {
            if let newValue = newValue {
                _name = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        get {
            _name
        }
    }
    
    var isFilled: Bool {
        !(_name ?? "").isEmpty && !(_phoneNumber ?? "").isEmpty && !(password ?? "").isEmpty
    }
    
    override init() { super.init() }
    
    private enum CodingKeys: String, CodingKey {
        case _name = "name"

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        _name = try container.decode(String?.self, forKey: ._name)
        
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: ._name)
    }
}
