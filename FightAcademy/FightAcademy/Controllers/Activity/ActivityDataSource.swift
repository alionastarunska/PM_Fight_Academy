//
//  ActivityDataSource.swift
//  FightAcademy
//
//  Created by Павел Снижко on 25.03.2021.
//

import UIKit

class ActivityDataSourse<Cell: ActivityCollectionViewCell>: NSObject, UICollectionViewDataSource {

    var activities: [ActivityModel]
    
    init(activities: [ActivityModel]) {
        self.activities = activities
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.name, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        
        // TODO: Move to delegates willDisplay ???

        cell.activity = activities[indexPath.item]
        
        return cell
    }
}


class PrefetchingDataSourceService: NSObject, UICollectionViewDataSourcePrefetching {
    
    
    let itemsPerBatch = 15
    var currentRow : Int = 1
    
    var dataTasks : [URLSessionDataTask] = []

    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
            guard let last = indexPaths.last else {
                return
            }
        
    }
    
    
    func fetchData(indexPathNumber: Int) {

    }
    
    
    func checkIfServerHasMore(indexPathNumber: Int) {
        
    }

    
    
}
