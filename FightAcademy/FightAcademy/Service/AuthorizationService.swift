//
//  AuthorizationService.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation
import SwiftKeychainWrapper

struct AuthorizationService {
    
    var isLogin: Bool {
        sessionStorage.sessionId != nil
    }
    private var sessionStorage: SessionStorage
    private var profileApiClient: ProfileApiClient
    
    init(sessionStorage: SessionStorage, profileApiClient: ProfileApiClient) {
        self.sessionStorage = sessionStorage
        self.profileApiClient = profileApiClient
    }
    
    func register(with registerData: RegisterModel) {
        profileApiClient
    }
}


final class SessionStorage {
    
    private enum Keys: String {
        case sessionID
    }
    
    private let keychainWrapper = KeychainWrapper.standard
    
    var sessionId: String? {
        set {
            if let newValue = newValue {
                keychainWrapper.set(newValue, forKey: Keys.sessionID.rawValue)
            } else {
                keychainWrapper.removeObject(forKey: Keys.sessionID.rawValue)
            }
        }
        
        get {
            keychainWrapper.string(forKey: Keys.sessionID.rawValue)
        }
    }
}

