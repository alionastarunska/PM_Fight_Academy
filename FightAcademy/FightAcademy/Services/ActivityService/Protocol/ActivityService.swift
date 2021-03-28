//
//  ActivityService.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/28/21.
//

import Foundation

protocol ActivityService {

    func incomingActivities(page: Int, completion: @escaping (Result<ApiResponse<Training>, Error>) -> Void)

}
