//
//  TableViewManager.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/28/21.
//

import UIKit

class TableViewManager<Cell: ConfigurableTableViewCell & ReusableTableViewCell>: NSObject,
                                                                                 UITableViewDelegate,
                                                                                 UITableViewDataSource {

    var onRowsEnded: (() -> Void)?

    private var canFetch: Bool = true

    private var items: [Cell.Item] = []

    func append(items: [Cell.Item]) -> [IndexPath] {

        let initialCount = self.items.count
        let endCount = initialCount + items.count

        let indices = (initialCount..<endCount).map { IndexPath(row: $0, section: 0) }
        self.items.append(contentsOf: items)

        canFetch = true

        return indices
    }

// MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier,
                                                       for: indexPath) as? Cell else {
            return .init()
        }

        cell.configure(with: items[indexPath.row])

        return cell
    }

// MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if items.count - 10 < indexPath.row {

            canFetch = false
            onRowsEnded?()

        }

    }

}
