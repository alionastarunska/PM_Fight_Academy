//
//  DateFormatter.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

extension DateFormatter {

    public static var pmDateFormatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateFormat = "MM.dd.yyyy"

        return formatter
    } ()

}
