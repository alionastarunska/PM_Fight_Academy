//
//  RequestableItem.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

public protocol RequestableItem {

    var queryItems: [URLQueryItem] { get }

    var method: HTTPMethod { get }
    var scheme: HTTPScheme { get }
    var host: String { get }
    var path: String { get }

    var headers: HTTPHeaders { get }

    func body() throws -> Data?
    func buildURLRequest(with commonHeaders: HTTPHeaders) throws -> URLRequest

}

public extension RequestableItem {

    var headers: HTTPHeaders {
        return [:]
    }

    var queryItems: [URLQueryItem] {
        return []
    }

    var method: HTTPMethod {
        return .get
    }

    var scheme: HTTPScheme {
        return .https
    }

    func body() throws -> Data? {
        return nil
    }

    func buildURLRequest(with commonHeaders: HTTPHeaders) throws -> URLRequest {

        var components = URLComponents()

        components.scheme = scheme.rawValue
        components.host = host
        components.path = path

        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            throw EndPointError.composeUrl
        }

        var request = URLRequest(url: url)
        do {
            request.httpBody = try body()
        } catch {
            throw EndPointError.composeUrl
        }

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = commonHeaders

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

}
