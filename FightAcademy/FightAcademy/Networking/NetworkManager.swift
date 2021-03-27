//
//  NetworkManager.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

class NetworkManager {

    func performFetch(with request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {

        URLSession.shared.dataTask(with: request) { [weak self, completion] (data, response, error) in

            guard let self = self else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {

                completion(.failure(NetworkError.noStatusCode))
                return

            }

            guard self.isValid(statusCode) else {

                completion(.failure(NetworkError.badStatusCode(statusCode: statusCode)))
                return

            }

            if let error = error {
                completion(.failure(error))
                return

            }

            guard let safeData = data else {
                completion(.failure(NetworkError.noData))
                return

            }

            completion(.success(safeData))

        }.resume()
    }

    func performFetchNoResponce(with request: URLRequest, completion: @escaping (Error?) -> Void) {

        URLSession.shared.dataTask(with: request) { [weak self, completion] (_, response, error) in

            guard let self = self else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {

                completion(NetworkError.noStatusCode)
                return

            }

            guard self.isValid(statusCode) else {

                completion(NetworkError.badStatusCode(statusCode: statusCode))
                return

            }

            if let error = error {
                completion(error)
                return

            }

            completion(nil)

        }.resume()
    }

}

extension NetworkManager {

    private func isValid(_ statusCode: StatusCode) -> Bool {
        return statusCode.isInRange(200..<300)
    }

}
