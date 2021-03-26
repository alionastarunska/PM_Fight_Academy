//
//  ActivityApiClient.swift
//  FightAcademy
//
//  Created by Павел Снижко on 26.03.2021.
//

import Foundation

protocol Prefetchable {
    
    associatedtype ModelType
    
    var fetchCompleted: ItemClosure<Result<([IndexPath], [ModelType])?, Error>>? { get set }
    var models: [ModelType] {get set}
    var isFetchInProgress: Bool { get set }
    var currentPage: Int { get set }
    var total: Int {get set}
    func fetchData()
}

class ActivityClientAPI: Prefetchable {
    
    var fetchCompleted: ItemClosure<Result<([IndexPath], [ActivityModel])?, Error>>?
    
    var total: Int = 10
    
    var currentPage: Int = 1
    
    var models = [ActivityModel]()
    
    var isFetchInProgress: Bool = false
    
    private var firstCall = true
    
    private var lastCall = false
    
    private func calculateIndexPathsToReload(from newModels: [ActivityModel]) -> [IndexPath] {
        let startIndex = models.count - newModels.count
        let endIndex = startIndex + newModels.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func fetchData() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        //TODO: decomment when data on backend will appear
        
        //        PMFightApi.shared.incomingActivities(page: page)
        APIClientMock.fetchData(page: currentPage) { [weak self] result in
            
            guard let self = self else { return }
            
            self.isFetchInProgress = false
            
            switch result {
            case .success(let response):
                
                //                print(response)
                
                DispatchQueue.main.async {
                    self.currentPage += 1
                    
                    self.isFetchInProgress = false
                    
                    self.total = response.paggination.totalPages
                    
                    self.models.append(contentsOf: response.contents)
                    
                    if response.paggination.page > 1 || self.firstCall {
                        
                        self.firstCall = false
                        
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.contents)
                        
                        //TODO: check for the ref cycle
                        self.fetchCompleted?(.success((indexPathsToReload, self.models)))
                        
                    } else {
                        
                        self.fetchCompleted?(.success(nil))
                        
                        print("onFetchCompleted(with: .none)")
                    }
                }
                
            case .failure(let error):
                
                self.fetchCompleted?(.failure(error))
            }
        }
    }
}
