//
//  ChoosingCoachViewController.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

protocol ChoosingCoach: UIViewController {

    var onSelectCoach: (() -> Void)? { get set }

}

class ChoosingCoachViewController: UIViewController, ChoosingCoach {
   
    @IBOutlet private weak var tableView: UITableView!
    
    private var coaches: [ChoosingCoachModel] = ChoosingCoachMock.make()
    private var dataSource: ChoosingCoachDataSource<ChoosingCoachTableViewCell>?
    
    var onSelectCoach: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Coaches"
        setupTableView()
    }

    @objc private func chooseCoach() {
        onSelectCoach?()
    }
    
    private func setupTableView() {
        dataSource = ChoosingCoachDataSource<ChoosingCoachTableViewCell>(coaches: coaches)
        tableView.register(ChoosingCoachTableViewCell.self)
        tableView.dataSource = dataSource
    }

}
