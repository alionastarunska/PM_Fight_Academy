//
//  ChoosingCoachDataSource.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import Foundation

import UIKit

class ChoosingCoachDataSource<Cell: ChoosingCoachTableViewCell>: NSObject, UITableViewDataSource {
    
    var coaches: [ChoosingCoachModel]

       init(coaches: [ChoosingCoachModel]) {
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
        return cell
    }
}
