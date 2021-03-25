//
//  ChoosingActivityDataSource.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

class ChoosingActivityDataSource<Cell: ChoosingActivityTableViewCell>: NSObject, UITableViewDataSource {
    
    var activity: [ChoosingActivityModel]

       init(activity: [ChoosingActivityModel]) {
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
}
