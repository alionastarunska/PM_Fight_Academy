//
//  ActivityApiClient.swift
//  FightAcademy
//
//  Created by Павел Снижко on 26.03.2021.
//

import Foundation


protocol Prefetchable {
    associatedtype ModelType
    
    var models: [ModelType] {get set}
    var isFetchInProgress: Bool { get set }
    var currentPage: Int { get set }
    var total: Int {get set}
    func fetchData(for page: Int)
}

class ActivityClientAPI: Prefetchable  {
        
    var total: Int = 0
    
    var currentPage: Int = 0

    var models = [ActivityModel]()
    
    var isFetchInProgress: Bool = false
    
    weak var delegate: ActivityViewController?
    
    private func calculateIndexPathsToReload(from newModels: [ActivityModel]) -> [IndexPath] {
      let startIndex = models.count - newModels.count
      let endIndex = startIndex + newModels.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

    func fetchData(for page: Int) {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        //TODO: decomment when data on backend will appear
        
//        PMFightApi.shared.incomingActivities(page: page)
        APIClientMock.fetchData(page: page) { [weak self] result in
            
            guard let self = self else { return }
            
            self.isFetchInProgress = false
            
            switch result {
            case .success(let response):
                
                print(response)
                
                DispatchQueue.main.async {
                  // 1
                  self.currentPage += 1
                  self.isFetchInProgress = false
                  // 2
                    self.total = response.paggination.totalPages
                    self.models.append(contentsOf: response.contents)
                  
                  // 3
                    if response.paggination.page > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.contents)
                        
                        //TODO: check for ref cycle
                        self.delegate?.onFetchCompleted(with: indexPathsToReload, and: self.models)
                  } else {
                    print("onFetchCompleted(with: .none)")
//                    self.delegate?.onFetchCompleted(with: .none)
                  }
                }
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}
