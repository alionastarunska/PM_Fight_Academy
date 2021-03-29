//
//  SettingModel.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/27/21.
//

import Foundation

struct SettingModel: Named, Imaged {

    let name: String
    let image: String

    let isAvailable: Bool = false

}

extension SettingModel {

    static func mock() -> [SettingModel] {
        return [SettingModel(name: "Personalization", image: "personalization"),
                SettingModel(name: "Notifications", image: "notification"),
                SettingModel(name: "Language", image: "language")
                ]
    }

}
