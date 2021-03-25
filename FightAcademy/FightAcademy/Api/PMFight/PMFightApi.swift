//
//  PMFightApi.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

class PMFightApi {

    private let netApiProvider = PMFightProvider()

    static let shared = PMFightApi()

    private init() {}

    func logIn(phone: String, password: String, completion: @escaping (Result<Token, Error>) -> Void) {
        netApiProvider.request(.login(login: phone, password: password)) { (result: Result<Token, Error>) in
            switch result {
            case .success(let token):
                SessionStorage().sessionId = token.raw
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

    func register(name: String, phone: String, password: String, completion: @escaping (Result<Token, Error>) -> Void) {
        netApiProvider.request(.register(name: name, login: phone, password: password)) { (result: Result<Token, Error>) in
            switch result {
            case .success(let token):
                SessionStorage().sessionId = token.raw
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

    func activities(completion: @escaping (Result<[TrainingType], Error>) -> Void) {
        netApiProvider.request(.activities,
                               completion: completion)

    }

    func coaches(with activity: Int, completion: @escaping (Result<[Coach], Error>) -> Void) {
        netApiProvider.request(.coaches(forActivity: activity),
                               completion: completion)

    }

    func dates(for activity: Int, with coach: Int, completion: @escaping (Result<[TrainingDay], Error>) -> Void) {
        netApiProvider.request(.dates(forActivity: activity, withCoach: coach),
                               completion: completion)
    }

    func time(for activity: Int, with coach: Int, on day: String, completion: @escaping (Result<[TrainingTime], Error>) -> Void) {
        netApiProvider.request(.time(forActivity: activity, withCoach: coach, onDay: day),
                               completion: completion)
    }

    func bookActivity(for activity: Int, with coach: Int, on day: String, time: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        netApiProvider.request(.bookActivity(forActivity: activity, withCoach: coach, onDay: day, time: time),
                               completion: completion)

    }

    func getCoaches(page: Int, completion: @escaping (Result<ApiResponse<Coach>, Error>) -> Void) {
        netApiProvider.request(.allCoaches(pageSize: 15, page: page),
                               completion: completion)

    }

    func activityHistory(page: Int, completion: @escaping (Result<ApiResponse<Training>, Error>) -> Void) {
        netApiProvider.request(.activityHistory(pageSize: 15, page: page),
                               completion: completion)

    }

    func incomingActivities(page: Int, completion: @escaping (Result<ApiResponse<Training>, Error>) -> Void) {
        netApiProvider.request(.incomingActivity(pageSize: 15, page: page),
                               completion: completion)
    }

}
