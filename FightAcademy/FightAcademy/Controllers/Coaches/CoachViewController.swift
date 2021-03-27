//
//  CoachViewController.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 21.03.2021.
//

import UIKit

class CoachViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var coaches: [CoachCellModel] = []
    private var dataSourse: CoachDataSourse<CoachTableViewCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Coach"
        
        coaches = CoachMock.make().map({ CoachCellModel(coach: $0) })
        
        setupTableView()
    }

    private func setupTableView() {
        dataSourse = CoachDataSourse<CoachTableViewCell>(coaches: coaches)
        tableView.register(CoachTableViewCell.self)
        tableView.dataSource = dataSourse
    }
}
