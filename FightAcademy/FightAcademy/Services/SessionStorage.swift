//
//  SessionStorage.swift
//  FightAcademy
//
//  Created by Павел Снижко on 24.03.2021.
//

import SwiftKeychainWrapper

final class SessionStorage {
    
    private enum Keys: String {
        case sessionID
    }
    
    private let keychainWrapper = KeychainWrapper.standard
    
    var sessionId: String? {
        
        get {
            keychainWrapper.string(forKey: Keys.sessionID.rawValue)
        }
        
        set {
            if let newValue = newValue {
                keychainWrapper.set(newValue, forKey: Keys.sessionID.rawValue)
            } else {
                keychainWrapper.removeObject(forKey: Keys.sessionID.rawValue)
            }
        }
    }
}
