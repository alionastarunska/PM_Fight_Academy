//
//  HumanApiError.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

enum HumanApiError: LocalizedError {

    case unauthorized
    case notFound
    case conflict
    case serverError

    case unresolved

    case noInternetConnection

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Our series of highly sophisticated and complex algorithms says that you are some sort of interplanetary alien-being."
            + " We need to make sure that we are dealing with a human and have to ask you to log in again!"
        case .notFound:
            return "We`re hiding everything from you... Or maybe the requested information doesn`t actually exist!"
        case .conflict:
            return "Got unusual response!"
        case .serverError:
            return "It`s always time for coffee break. We should be back by the time you finish your coffee!"
        case .unresolved:
            return "Got unusual response. Something really bad happen!"
        case .noInternetConnection:
            return "Your internet connection probably was lost!"
        }
    }

}
