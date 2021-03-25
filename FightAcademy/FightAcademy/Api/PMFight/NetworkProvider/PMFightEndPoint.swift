//
//  PMFightEndPoint.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

enum PMFightEndPoint {

    case register(name: String, login: String, password: String)
    case login(login: String, password: String)

    case activities
    case coaches(forActivity: Int)
    case dates(forActivity: Int, withCoach: Int)
    case time(forActivity: Int, withCoach: Int, onDay: String)
    case bookActivity(forActivity: Int, withCoach: Int, onDay: String, time: String)

    case incomingActivity(pageSize: Int, page: Int)
    case activityHistory(pageSize: Int, page: Int)

    case allCoaches(pageSize: Int, page: Int)

}

extension PMFightEndPoint: RequestableItem {

    var host: String {
        return "pmfightacademyclient-92m8i.ondigitalocean.app"
    }

    var path: String {
        switch self {
        case .register:
            return "/Clients/Register"
        case .login:
            return "/Clients/Login"

        case .activities:
            return "/Booking"
        case let .coaches(activityId):
            return "/Booking/\(activityId)"
        case let .dates(activityId, coachId):
            return "/Booking/\(activityId)/\(coachId)"
        case let .time(activityId, coachId, day):
            return "/Booking/\(activityId)/\(coachId)/\(day)"
        case .bookActivity:
            return "/Booking"

        case let .incomingActivity(pageSize, page):
            return "/Booking/active/\(pageSize)/\(page)"
        case let .activityHistory(pageSize, page):
            return "/Booking/history/\(pageSize)/\(page)"

        case let .allCoaches(pageSize, page):
            return "/Coaches/\(pageSize)/\(page)"

        }
    }

    var method: HTTPMethod {
        switch self {
        case .register, .login, .bookActivity:
            return .post
        default:
            return .get
        }
    }

    func body() throws -> Data? {
        switch self {
        case let .register(name, login, password):

            struct RegisterUser: Encodable {

                let name: String
                let login: String
                let password: String

            }

            let user = RegisterUser(name: name,
                                    login: login,
                                    password: password)

            return try JSONEncoder().encode(user)

        case let .login(login, password):

            struct LoginUser: Encodable {

                let login: String
                let password: String

            }

            let user = LoginUser(login: login,
                                 password: password)

            return try JSONEncoder().encode(user)

        case let .bookActivity(forActivity, withCoach, onDay, time):

            struct BookTraining: Encodable {

                let date: String
                let time: String
                let serviceId: Int
                let coachId: Int

            }

            let training = BookTraining(date: onDay,
                                    time: time,
                                    serviceId: forActivity,
                                    coachId: withCoach)

            return try JSONEncoder().encode(training)

        default:
            return nil
        }
    }

}
