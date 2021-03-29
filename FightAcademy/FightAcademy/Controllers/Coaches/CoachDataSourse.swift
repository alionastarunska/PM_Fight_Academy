//
//  CoachDataSource.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 21.03.2021.
//

import UIKit

class CoachDataSource<Cell: ConfigurableTableViewCell & ReusableTableViewCell>: NSObject, UITableViewDataSource {

    var items: [Cell.Item]

    init(items: [Cell.Item]) {
        self.items = items
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }

        cell.configure(with: items[indexPath.row])
        (cell as? ExpandableTableViewCell)?.expandEvent = {

            cell.configure(with: self.items[indexPath.row])
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell

    }

    // MARK: - Public

    func append(items: [Cell.Item]) -> [IndexPath] {
        let count = self.items.count
        self.items.append(contentsOf: items)
        var indexes = [IndexPath]()
        for idx in 0..<items.count {
            indexes.append(IndexPath(row: count + idx, section: 0))
        }
        return indexes
    }

}
