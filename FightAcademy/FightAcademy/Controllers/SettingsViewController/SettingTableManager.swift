//
//  SettingTableManager.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/26/21.
//

import UIKit

class SettingTableManager: NSObject {
    
    var items: [SettingModel]

    init(items: [SettingModel]) {
        self.items = items
    }

}
extension SettingTableManager: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.section])
        return cell

    }

}

extension SettingTableManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView()
        view.backgroundColor = .clear
        return view

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

}
