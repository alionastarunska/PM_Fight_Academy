//
//  ActivityProvider.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/28/21.
//

import Foundation

struct ActivityProvider: ActivityService {

    var service: ActivityService

    func incomingActivities(page: Int, completion: @escaping (Result<ApiResponse<Training>, Error>) -> Void) {
        service.incomingActivities(page: page, completion: completion)
    }

}
