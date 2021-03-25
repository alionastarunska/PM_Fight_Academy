//
//  NetworkError.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

enum NetworkError: Error {

    case noData
    case badStatusCode(statusCode: StatusCode)
    case noStatusCode

}
