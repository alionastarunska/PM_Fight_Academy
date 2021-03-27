//
//  SettingTableViewCell.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/26/21.
//

import UIKit

class SettingTableViewCell: UITableViewCell, ConfigurableTableViewCell, ReusableTableViewCell {

    @IBOutlet private weak var settingImageView: UIImageView!
    @IBOutlet private weak var settingLabel: UILabel!

    func setSettingImage(_ image: UIImage?) {
        settingImageView.image = image
    }

    func setSettingImage(_ imageName: String) {
        settingImageView.image = UIImage(named: imageName)
    }

    func setSettingName(_ name: String?) {
        settingLabel.text = name
    }

}

extension SettingTableViewCell {

    func configure(with item: SettingModel) {
        setSettingImage(item.image)
        setSettingName(item.name)
    }

}
