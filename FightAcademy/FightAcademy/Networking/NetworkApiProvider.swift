//
//  NetworkApiProvider.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

protocol NetworkApiProvider {

    associatedtype ApiEndpoint: RequestableItem

    func request<T: Decodable>(_ endPoint: ApiEndpoint, completion: @escaping (Result<T, Error>) -> Void)
    func request(_ endPoint: ApiEndpoint, completion: @escaping (Error?) -> Void)

}
