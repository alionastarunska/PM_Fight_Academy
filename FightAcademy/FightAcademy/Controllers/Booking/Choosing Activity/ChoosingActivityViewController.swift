//
//  ChoosingActivityViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol ChoosingActivity: UIViewController {

    var onSelectActivityType: ((ChoosingActivityModel) -> Void)? { get set }

}

class ChoosingActivityViewController: UIViewController, ChoosingActivity {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var onSelectActivityType: ((ChoosingActivityModel) -> Void)?
    
    private var activity: [ChoosingActivityModel] = ChoosingActivityMock.make()
    private var dataSource: ChoosingActivityDataSource<ChoosingActivityTableViewCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activities"
        setupTableView()
    }
    
    private func setupTableView() {
        dataSource = ChoosingActivityDataSource<ChoosingActivityTableViewCell>(activity: activity)
        tableView.register(ChoosingActivityTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

}

extension ChoosingActivityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard activity.indices.contains(indexPath.row) else { return }
        let selectedActivity = activity[indexPath.row]
        onSelectActivityType?(selectedActivity)
    }
}
