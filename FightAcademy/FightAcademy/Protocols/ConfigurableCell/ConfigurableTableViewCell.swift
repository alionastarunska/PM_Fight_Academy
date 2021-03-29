//
//  ConfigurableTableViewCell.swift
//  Homework_4
//
//  Created by Aliona Starunska on 25.01.2021.
//

import UIKit

protocol ConfigurableTableViewCell: UITableViewCell {

    associatedtype Item

    func configure(with item: Item)

}
