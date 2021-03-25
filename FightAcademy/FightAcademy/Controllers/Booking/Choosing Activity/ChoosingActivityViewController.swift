//
//  ChoosingActivityViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol ChoosingActivity: UIViewController {

    var onSelectActivityType: (() -> Void)? { get set }

}

class ChoosingActivityViewController: UIViewController, ChoosingActivity {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var onSelectActivityType: (() -> Void)?
    
    private var activity: [ChoosingActivityModel] = ChoosingActivityMock.make()
    private var dataSource: ChoosingActivityDataSource<ChoosingActivityTableViewCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activities"
        setupTableView()
    }

    @objc private func chooseActivity() {
        onSelectActivityType?()
    }
    
    private func setupTableView() {
        dataSource = ChoosingActivityDataSource<ChoosingActivityTableViewCell>(activity: activity)
        tableView.register(ChoosingActivityTableViewCell.self)
        tableView.dataSource = dataSource
    }

}
