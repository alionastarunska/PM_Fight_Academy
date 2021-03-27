//
//  HistoryApiClient.swift
//  FightAcademy
//
//  Created by Павел Снижко on 26.03.2021.
//

import Foundation


//TODO: remake it very bad solution. Violance DRY !!!!!

class HistoryClientApi: Prefetchable {
    
    var fetchCompleted: ItemClosure<Result<([IndexPath], [Training])?, Error>>?
    
    var total: Int = 10
    
    var currentPage: Int = 1
    
    var models = [Training]()
    
    var isFetchInProgress: Bool = false
    
    private var firstCall = true
    
    private var lastCall = false
    
    private func calculateIndexPathsToReload(from newModels: [Training]) -> [IndexPath] {
        let startIndex = models.count - newModels.count
        let endIndex = startIndex + newModels.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func fetchData() {
        guard !isFetchInProgress && !lastCall else {
            return
        }
        
        isFetchInProgress = true
        
        //TODO: decomment when data on backend will appear
        
            PMFightApi.shared.incomingActivities(page: currentPage) { [weak self] result in
            
            guard let self = self else { return }
            
            self.isFetchInProgress = false
            
            switch result {
            case .success(let response):
                
                                print(response)
                
                DispatchQueue.main.async {
                    self.currentPage += 1
                    
                    self.isFetchInProgress = false
                    
                    self.total = response.paggination.totalPages
                    
                    self.models.append(contentsOf: response.contents)
                    
                    if (response.paggination.page > 1 || self.firstCall) && !self.lastCall {
                        
                        self.firstCall = false
                        
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.contents)
                        
                        self.lastCall = !response.paggination.hasNextPage
                        
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
