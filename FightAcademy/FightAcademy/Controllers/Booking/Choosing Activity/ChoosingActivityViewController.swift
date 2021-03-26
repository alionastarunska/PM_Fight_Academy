//
//  ChoosingActivityViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol ChoosingActivity: UIViewController, LoadingDisplaying, ErrorDisplaying {

    var onSelectActivityType: ((TrainingType) -> Void)? { get set }

}

class ChoosingActivityViewController: UIViewController, ChoosingActivity {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var onSelectActivityType: ((TrainingType) -> Void)?
    
    private var activity: [TrainingType] = []
    private var dataSource: ChoosingActivityDataSource<ChoosingActivityTableViewCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activities"
        loadActivities()
        setupTableView()
    }
    
    private func setupTableView() {
        dataSource = ChoosingActivityDataSource<ChoosingActivityTableViewCell>(activity: activity)
        tableView.register(ChoosingActivityTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    private func loadActivities() {
        startLoading()
        PMFightApi.shared.activities { [weak self] result in
            self?.endLoading()
            switch result {
            case .success(let response):
                self?.activity.append(contentsOf: response)
                guard let indexes = self?.dataSource?.append(items: response), !indexes.isEmpty else { return }
                self?.tableView.insertRows(at: indexes, with: .none)
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
}

extension ChoosingActivityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard activity.indices.contains(indexPath.row) else { return }
        let selectedActivity = activity[indexPath.row]
        onSelectActivityType?(selectedActivity)
    }
}
