//
//  CoachDataSourse.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 21.03.2021.
//

import UIKit

typealias CoachViewCell = ConfigurableTableViewCell & ReusableTableViewCell & ExpandableTableViewCell

class CoachDataSourse<Cell: CoachViewCell>: NSObject, UITableViewDataSource {
    
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
        cell.expandEvent = {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }
}
