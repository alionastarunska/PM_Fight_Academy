//
//  ActivityDataSource.swift
//  FightAcademy
//
//  Created by Павел Снижко on 25.03.2021.
//

import UIKit

class ActivityDataSource<Cell: ActivityCollectionViewCell>: NSObject,
                                                            UICollectionViewDataSource,
                                                            UICollectionViewDataSourcePrefetching {
    
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    
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
        
        cell.activity = activities[indexPath.item]
        
        return cell
    }
    
    
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.activities.count
    }

    
}







//
//class PrefetchingDataSourceService: NSObject, UICollectionViewDataSourcePrefetching {
//
//    let itemsPerBatch = 15
////    var currentRow : Int = 1
////    var dataTasks : [URLSessionDataTask] = []
//    var models = [Activity]()
//    var currentPage: Int = 0
//
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        guard let last = indexPaths.last else {
//            return
//        }
//
//        print(last)
//
////        fetchData(indexPathNumber: last)
//
//    }
//
//    func fetchData(indexPathNumber: Int) {
//
//    }
//
//    // TODO: change to decodable type
//
//
//
//    func checkIfServerHasMore(indexPathNumber: Int) {
//
//    }
//
//}
