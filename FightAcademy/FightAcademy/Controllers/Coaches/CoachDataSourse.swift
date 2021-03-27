//
//  CoachDataSourse.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 21.03.2021.
//

import UIKit

class CoachDataSourse<Cell: CoachTableViewCell>: NSObject, UITableViewDataSource {
    
    var coaches: [CoachCellModel]

       init(coaches: [CoachCellModel]) {
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
        cell.expandEvent = {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }
}
