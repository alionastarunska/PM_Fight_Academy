//
//  PMFightApi.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

class PMFightApi: LogInService, RegistrationService {

    private let netApiProvider = PMFightProvider()

    static let shared = PMFightApi()

    private init() {}

    func logIn(phone: String, password: String, completion: @escaping (Error?) -> Void) {
        requestAuthentication(with: .login(login: phone, password: password), completion: completion)
    }

    func registrate(phone: String, password: String, name: String, completion: @escaping (Error?) -> Void) {
        requestAuthentication(with: .register(name: name, login: phone, password: password), completion: completion)
    }

    func activities(completion: @escaping (Result<[TrainingType], Error>) -> Void) {
        request(with: .activities, completion: completion)
    }

    func coaches(with activity: Int, completion: @escaping (Result<[Coach], Error>) -> Void) {
        request(with: .coaches(forActivity: activity), completion: completion)
    }

    func dates(for activity: Int, with coach: Int, completion: @escaping (Result<[TrainingDay], Error>) -> Void) {
        request(with: .dates(forActivity: activity, withCoach: coach), completion: completion)
    }

    func time(for activity: Int, with coach: Int, on day: String, completion: @escaping (Result<[TrainingTime], Error>) -> Void) {
        request(with: .time(forActivity: activity, withCoach: coach, onDay: day), completion: completion)
    }

    func bookActivity(for activity: Int, with coach: Int, on day: String, time: String, completion: @escaping (Error?) -> Void) {
        request(with: .bookActivity(forActivity: activity, withCoach: coach, onDay: day, time: time), completion: completion)
    }

    func getCoaches(page: Int, completion: @escaping (Result<ApiResponse<Coach>, Error>) -> Void) {
        request(with: .allCoaches(pageSize: 15, page: page), completion: completion)
    }
    func activityHistory(page: Int, completion: @escaping (Result<ApiResponse<Training>, Error>) -> Void) {
        request(with: .activityHistory(pageSize: 15, page: page), completion: completion)
    }

    func incomingActivities(page: Int, completion: @escaping (Result<ApiResponse<Training>, Error>) -> Void) {
        request(with: .incomingActivity(pageSize: 15, page: page), completion: completion)
    }

}

private extension PMFightApi {

    func requestAuthentication(with endpoint: PMFightProvider.ApiEndpoint, completion: @escaping (Error?) -> Void) {
        netApiProvider.request(endpoint) { (result: Result<Token, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    SessionStorage().sessionId = token.raw
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }

    func request<T: Decodable>(with endpoint: PMFightProvider.ApiEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        netApiProvider.request(endpoint) { (result: Result<T, Error>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func request(with endpoint: PMFightProvider.ApiEndpoint, completion: @escaping (Error?) -> Void) {
        netApiProvider.request(endpoint) { error in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }

}
