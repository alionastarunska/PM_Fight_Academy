//
//  ChoosingActivityDataSource.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

class ChoosingActivityDataSource<Cell: ChoosingActivityTableViewCell>: NSObject, UITableViewDataSource {

    var activity: [TrainingType]

       init(activity: [TrainingType]) {
           self.activity = activity
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(with: activity[indexPath.row])

        return cell
    }

    func append(items: [Cell.Item]) -> [IndexPath] {
        let count = self.activity.count
        self.activity.append(contentsOf: items)
        var indexes = [IndexPath]()
        for idx in 0..<items.count {
            indexes.append(IndexPath(row: count + idx, section: 0))
        }
        return indexes
    }

}
