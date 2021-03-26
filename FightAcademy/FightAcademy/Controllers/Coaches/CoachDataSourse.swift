//
//  CoachDataSource.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 21.03.2021.
//

import UIKit

typealias TableViewCell = UITableViewCell & ReusableCell & ConfigurableCell

class CoachDataSource<Cell: TableViewCell>: NSObject, UITableViewDataSource {
    
    var coaches: [Cell.Item]

    init(coaches: [Cell.Item]) {
        self.coaches = coaches
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coaches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(with: coaches[indexPath.row])
        (cell as? CoachTableViewCell)?.expandEvent = {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }
    
    // MARK: - Public
    
    func append(items: [Cell.Item]) -> [IndexPath] {
        let count = self.coaches.count
        self.coaches.append(contentsOf: items)
        var indexes = [IndexPath]()
        for idx in 0..<items.count {
            indexes.append(IndexPath(row: count + idx, section: 0))
        }
        return indexes
    }
}
