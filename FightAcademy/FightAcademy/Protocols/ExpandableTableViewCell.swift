//
//  ExpandableTableViewCell.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import UIKit

protocol ExpandableTableViewCell: UITableViewCell {

    typealias Event = () -> Void

    var expandEvent: Event? { get set }

}
