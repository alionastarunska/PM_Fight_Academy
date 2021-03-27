//
//  SocialNetworkDataSource.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import UIKit

typealias SocialTableViewCell = ConfigurableTableViewCell & ReusableTableViewCell

class SocialNetworkDataSourse<Cell: SocialTableViewCell>: NSObject, UITableViewDataSource {

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
        return cell
    }

}
