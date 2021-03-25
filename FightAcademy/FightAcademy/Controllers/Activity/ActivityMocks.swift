//
//  ActivityMocks.swift
//  FightAcademy
//
//  Created by Павел Снижко on 25.03.2021.
//

import Foundation

struct ActivityModel {
    let id: Int
    let serviceName: String
    let date: String
    let coachFirstName: String
    let coachLastName: String
    let time: String
    let price: Double
}

struct ActivityService {
    
    func getActivities(page: Int) -> [ActivityModel] {
        var activities = [ActivityModel]()

        for i in 0...15 {
            activities.append(ActivityModel(id: i,
                                            serviceName: "Karate",
                                            date: "22.1.3", coachFirstName: "Lorem",
                                            coachLastName: "Ipsum",
                                            time: "10:0",
                                            price: 10000))
        
        }
        
        return activities
    }
}


class APIClientMock {
        
    func fetchData(pagination: Bool,  complition: @escaping (Result<[ActivityModel], Error>) -> Void ) {
        
        
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            var activities = [ActivityModel]()

            for i in 0...15 {
                activities.append(ActivityModel(id: i,
                                                serviceName: "Karate",
                                                date: "22.1.3", coachFirstName: "Lorem",
                                                coachLastName: "Ipsum",
                                                time: "10:0",
                                                price: 10000))
            
            }
            
            var newActivities = [ActivityModel]()
            
            for i in 0...10 {
                newActivities.append(ActivityModel(id: i,
                                                serviceName: "Box",
                                                date: "25.01.34", coachFirstName: "Pasha",
                                                coachLastName: "Ipsum",
                                                time: "20:00",
                                                price: 100))
            }
            
            complition(.success(pagination ? newActivities : activities))
        }
        
    }
}
