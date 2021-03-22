//
//  UILabel.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 21.03.2021.
//

import UIKit

extension String {
    func size(with font: UIFont, constrainedTo width: CGFloat) -> CGFloat {
        return NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                                   options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                   attributes: [.font: font],
                                                   context: nil).height
    }
}
