//
//  UITableView.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import UIKit

extension UITableView {

    func registerNib<T: ReusableTableViewCell>(for cellType: T.Type) {
        register(cellType.cellNib,
                 forCellReuseIdentifier: cellType.reuseIdentifier)
    }

}
