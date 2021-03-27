//
//  ActivityMocks.swift
//  FightAcademy
//
//  Created by Павел Снижко on 25.03.2021.
//

import Foundation

struct ActivityModel: Decodable {
    let id: Int
    let serviceName: String
    let date: String
    let coachFirstName: String
    let coachLastName: String
    let time: String
    let price: Double
}

class APIClientMock {
    
    static func fetchData(page: Int, completion: @escaping (Result<ApiResponse<ActivityModel>, Error>) -> Void ) {
        var activities = [ActivityModel]()
        let totalPage = 10
        let hasNextPage: Bool
        
        if page == totalPage {
            hasNextPage = false
        } else {
            hasNextPage = true
        }
        
        for _ in 0...15 {
            activities.append(ActivityModel(id: page,
                                            serviceName: "Karate \(page)",
                                            date: "22.1.3", coachFirstName: "Lorem",
                                            coachLastName: "Ipsum",
                                            time: "10:0",
                                            price: 10000))
        
        }
        
        let responseModel = ApiResponse(contents: activities,
                                        paggination: Paggination(page: page,
                                                                 totalPages: totalPage ,
                                                                 hasPreviousPage: false,
                                                                 hasNextPage: hasNextPage))
        
        PMFightApi.shared.incomingActivities(page: page) { result in
            switch result {
            case .success:
            completion(.success(responseModel))
            case .failure(let error):
            completion(.failure((error)))
            }
        }
        
    }
}
