//
//  HistoryDataSource.swift
//  FightAcademy
//
//  Created by Павел Снижко on 26.03.2021.
//

import UIKit


class HistoryDataSource<Cell: HistoryCollectionViewCell>: NSObject,
                                                            UICollectionViewDataSource,
                                                            UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(indexPaths)
        if indexPaths.contains(where: isLoadingCell(for:)) {
            self.apiCaller?.fetchData()
        } else {
            return
        }
    }
    
    var trainings: [Training]
    let apiCaller: HistoryClientApi?
    
    init(activities: [Training] = [], apiCaller: HistoryClientApi?) {
        self.trainings = activities
        self.apiCaller = apiCaller
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return trainings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.name,
                                                            for: indexPath) as? Cell, indexPath.item != trainings.count
        else {
            fatalError()
        }
        
        cell.training = trainings[indexPath.item]
                
        return cell
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.item >= self.trainings.count - 1
    }
}

extension ActivityDataSource {
    private func makeFirstCall() {
        self.apiCaller?.fetchData()
    }
}
