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

    private let headers: HTTPHeaders = ["Content-Type": "application/json",
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

    func request(_ endPoint: ApiEndpoint, completion: @escaping (Error?) -> Void) {

        do {

            let request = try buildRequest(for: endPoint)
            perform(request, completion: completion)

        } catch {
            completion(error)
        }

    }

}

private extension PMFightProvider {

    func perform<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {

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

    func perform(_ request: URLRequest, completion: @escaping (Error?) -> Void) {

        networkManager.performFetchNoResponce(with: request, completion: completion)

    }

    func buildRequest(for endPoint: ApiEndpoint) throws -> URLRequest {
        var urlRequest = try endPoint.buildURLRequest(with: headers)

        if let token = storage.sessionId {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }

    func handleError(_ error: Error) -> HumanApiError {

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
