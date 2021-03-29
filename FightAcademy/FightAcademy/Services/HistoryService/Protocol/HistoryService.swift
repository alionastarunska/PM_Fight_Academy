//
//  HistoryService.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/28/21.
//

import Foundation

protocol HistoryService {

    func activityHistory(page: Int, completion: @escaping (Result<ApiResponse<Training>, Error>) -> Void)

}
