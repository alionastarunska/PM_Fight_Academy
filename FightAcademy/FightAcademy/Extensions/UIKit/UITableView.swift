//
//  UITableView.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import UIKit

extension UITableView {

    func register<T: ReusableTableViewCell>(_ type: T.Type) {
        register(type.cellNib, forCellReuseIdentifier: type.reuseIdentifier)
    }

}
