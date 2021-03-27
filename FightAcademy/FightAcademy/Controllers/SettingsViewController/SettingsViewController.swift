//
//  SettingsViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol Settings: UIViewController {

    var onLogOut: (() -> Void)? { get set }

}

class SettingsViewController: UIViewController, Settings {

    var onLogOut: (() -> Void)?

    @IBOutlet private weak var tableView: UITableView!
    private var settingTableManager: SettingTableManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"

        setupTableView()
    }

    private func setupTableView() {
        settingTableManager = SettingTableManager(items: SettingModel.mock())
        tableView.register(SettingTableViewCell.self)
        tableView.dataSource = settingTableManager
        tableView.delegate = settingTableManager
    }

    @IBAction private func logOutButtonTapped(_ sender: UIButton) {
        SessionStorage().sessionId = nil
        onLogOut?()
    }
    
    init() {
        super.init(nibName: "SettingsViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

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

protocol Named {
    var name: String { get }
}
protocol Imaged {
    var image: String { get }
}
