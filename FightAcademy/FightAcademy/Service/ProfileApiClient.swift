//
//  ProfileApiClient.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation

class MockNetworkManager: Networking {
    func execute<T>(requestBody: Data, completion: Result<T, Error>) {
        
    }
}

protocol Networking {
    func execute<T>(requestBody: Data, completion: Result<T, Error>)
}

struct ProfileApiClient {
    let networkService: Networking
    
    init(networkService: Networking) {
        self.networkService = networkService
    }
    
    
}
