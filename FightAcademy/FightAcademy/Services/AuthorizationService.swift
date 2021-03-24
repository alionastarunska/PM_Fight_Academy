//
//  AuthorizationService.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation
import SwiftKeychainWrapper

struct AuthorizationService {
    
    var onCompleteAuth: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    var isLogin: Bool {
        // use it for checking when splash screen wil be loading
        sessionStorage.sessionId != nil
    }
    
    private var sessionStorage: SessionStorage
    private var profileApiClient: ProfileApiClient
    
    init(sessionStorage: SessionStorage, profileApiClient: ProfileApiClient) {
        self.sessionStorage = sessionStorage
        self.profileApiClient = profileApiClient
    }
    
    func authorize<T: Encodable>(with authModel: T, completion: @escaping ItemClosure<Result<Void?, NetworkingError>>) {
        
        // INFO:  MOCK
        
        let resourceMock = ResourceMock(url: "parimatch/client/register")
        
        profileApiClient.execute(resource: resourceMock, data: authModel) { result in
            switch result {
            case .success(let model):
                sessionStorage.sessionId = model.token
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

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
