//
//  PMFightProvider.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

class PMFightProvider: NetworkApiProvider {

    typealias ApiEndpoint = PMFightEndPoint

    private let networkManager = NetworkManager()
    private let decoder = JSONDecoder()

    private let commonHeaders: HTTPHeaders = ["Content-Type": "application/json",
                                              "Accept": "text/plain"]
    private var storage = SessionStorage()

    func request<T: Decodable>(_ endPoint: ApiEndpoint, completion: @escaping (Result<T, Error>) -> Void) {

        do {

            let request = try buildRequest(for: endPoint)
            perform(request, completion: completion)

        } catch {

            completion(.failure(error))

        }

    }

    private func perform<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {

        networkManager.performFetch(with: request) { [decoder, completion] (result) in

            do {

                let data = try result.get()

                let decoded = try decoder.decode(T.self, from: data)

                completion(.success(decoded))

            } catch {
                print(error)
                completion(.failure(self.handleError(error)))

            }

        }

    }

    private func buildRequest(for endPoint: ApiEndpoint) throws -> URLRequest {
        var urlRequest = try endPoint.buildURLRequest(with: commonHeaders)
        if let token = storage.sessionId {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }

    private func handleError(_ error: Error) -> HumanApiError {

        switch error {
        case NetworkError.badStatusCode(let statusCode):

            switch statusCode {
            case 400:
                return HumanApiError.userError
            case 401:
                return HumanApiError.unauthorized
            case 404:
                return HumanApiError.notFound
            case 409:
                return HumanApiError.notFound
            default:
                return HumanApiError.serverError
            }

        case NetworkError.noStatusCode, NetworkError.noData:

            return HumanApiError.noInternetConnection

        case  EndPointError.composeUrl:

            return HumanApiError.notFound

        default:

            return HumanApiError.unresolved
        }
    }

}
