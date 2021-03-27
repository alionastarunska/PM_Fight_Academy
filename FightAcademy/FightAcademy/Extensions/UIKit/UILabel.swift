//
//  UILabel.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import UIKit

extension UILabel {

    func height(with constrainedWidth: CGFloat) -> CGFloat {
        guard let text = text, let font = font else {
            return 0
        }

        let size = CGSize(width: constrainedWidth,
                          height: CGFloat(MAXFLOAT))

        return NSString(string: text).boundingRect(with: size,
                                                   options: [.usesLineFragmentOrigin],
                                                   attributes: [.font: font],
                                                   context: nil).height
    }

}
