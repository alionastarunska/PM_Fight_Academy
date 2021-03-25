//
//  StatusCode.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

typealias StatusCode = Int

extension StatusCode {

    func isInRange(_ range: Range<Int>) -> Bool {
        return range ~= self
    }

    func isInRange(_ range: ClosedRange<Int>) -> Bool {
        return range ~= self
    }

}
