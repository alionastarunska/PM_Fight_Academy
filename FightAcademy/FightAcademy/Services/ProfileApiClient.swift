//
//  ProfileApiClient.swift
//  FightAcademy
//
//  Created by Павел Снижко on 20.03.2021.
//

import Foundation


//MOCKS

class MockNetworkManager: Networking {
    func execute(requestBody: Data, completion: @escaping ItemClosure<Result<ResponseModel, NetworkingError>> ) {
        completion(.success(ResponseModel(token: "11111")))
    }
}

protocol Networking {
    func execute(requestBody: Data, completion: @escaping ItemClosure<Result<ResponseModel, NetworkingError>> )
}


enum NetworkingError: Error {
    case conflict
    case badRequest
    case badRequestData
}



struct ResourceMock {
    let url: String
}


struct ProfileApiClient {
    let networkService: Networking
    let jsonEcoder: JSONEncoder
    
    init(networkService: Networking, jsonEcoder: JSONEncoder) {
        self.networkService = networkService
        self.jsonEcoder = jsonEcoder
    }
    
    func execute<T: Encodable>(resource: ResourceMock ,data: T,  completion: @escaping ItemClosure<Result<ResponseModel, NetworkingError>>) {
        
        var requestBody: Data!
        
        do {
            requestBody = try jsonEcoder.encode(data)
        } catch {
            return completion(.failure(.badRequestData))
        }
        
        networkService.execute(requestBody: requestBody) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

}


