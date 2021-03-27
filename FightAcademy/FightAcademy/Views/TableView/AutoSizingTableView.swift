//
//  AutoSizingTableView.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import UIKit

class AutoSizingTableView: UITableView {

    override var intrinsicContentSize: CGSize {
        var height: CGFloat = 0
         for section in 0..<self.numberOfSections {
             let nRowsSection = self.numberOfRows(inSection: section)
             for row in 0..<nRowsSection {
                 height += self.rectForRow(at: IndexPath(row: row, section: section)).size.height
             }
         }
         return CGSize(width: -1, height: height )
    }

}
