//
//  HistoryProvider.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/28/21.
//

import Foundation

struct HistoryProvider: HistoryService {

    var service: HistoryService

    func activityHistory(page: Int, completion: @escaping (Result<ApiResponse<Training>, Error>) -> Void) {
        service.activityHistory(page: page, completion: completion)
    }

}
