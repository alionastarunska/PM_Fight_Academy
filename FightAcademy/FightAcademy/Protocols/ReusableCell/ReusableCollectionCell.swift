//
//  ReusableCollectionCell.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import UIKit

protocol ReusableCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier: String { get }
    static var cellNib: UINib { get }

}

extension ReusableCollectionViewCell {

    static var reuseIdentifier: String { return String(describing: self) }
    static var cellNib: UINib { return UINib(nibName: String(describing: self), bundle: nil) }

}
