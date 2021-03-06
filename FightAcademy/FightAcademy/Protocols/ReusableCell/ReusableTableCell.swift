//
//  ReusableTableViewCell.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 18.01.2021.
//

import UIKit

protocol ReusableTableViewCell: UITableViewCell {

    static var reuseIdentifier: String { get }
    static var cellNib: UINib { get }

}

extension ReusableTableViewCell {

    static var reuseIdentifier: String { return String(describing: self) }
    static var cellNib: UINib { return UINib(nibName: String(describing: self), bundle: nil) }

}
