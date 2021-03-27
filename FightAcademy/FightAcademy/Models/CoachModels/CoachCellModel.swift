//
//  CoachCellModel.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

class CoachCellModel {

    var coach: Coach
    var isExpanded: Bool

    init(coach: Coach, isExpanded: Bool = false) {
        self.coach = coach
        self.isExpanded = isExpanded
    }

}
