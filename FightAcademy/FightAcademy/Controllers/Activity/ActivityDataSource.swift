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
        print(indexPaths)

        if indexPaths.contains(where: isLoadingCell(for:)) {
            self.apiCaller?.fetchData()
        } else {
            return
        }
    }

    var activities: [Training]
    let apiCaller: ActivityClientAPI?

    init(activities: [Training] = [], apiCaller: ActivityClientAPI?) {
        self.activities = activities
        self.apiCaller = apiCaller
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return activities.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.name,
                                                            for: indexPath) as? Cell, indexPath.item != activities.count
        else {
            fatalError()
        }

        cell.training = activities[indexPath.item]

        return cell
    }

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.item >= self.activities.count - 1
    }

}

extension ActivityDataSource {

    private func makeFirstCall() {
        self.apiCaller?.fetchData()
    }

}
