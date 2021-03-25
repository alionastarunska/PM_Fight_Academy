//
//  AuthorizationService.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation

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

    // note:
    func login(phone: String, password: String, completion: @escaping (Result<Token, Error>) -> Void) {
        PMFightApi.shared.logIn(phone: phone, password: password, completion: completion)
    }
    
    func reg(phone: String, password: String, name: String, completion: @escaping (Result<Token, Error>) -> Void) {
        PMFightApi.shared.register(name: name, phone: phone, password: password, completion: completion)
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
