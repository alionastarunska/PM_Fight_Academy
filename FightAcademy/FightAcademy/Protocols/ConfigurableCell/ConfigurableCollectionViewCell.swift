//
//  ConfigurableCollectionViewCell.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import UIKit

protocol ConfigurableCollectionViewCell: UICollectionViewCell {

    associatedtype Item

    func configure(with item: Item)

}
