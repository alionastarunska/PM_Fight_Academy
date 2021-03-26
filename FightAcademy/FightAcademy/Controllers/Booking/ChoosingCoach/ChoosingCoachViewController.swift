//
//  ChoosingCoachViewController.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

protocol ChoosingCoach: UIViewController, LoadingDisplaying, ErrorDisplaying {

    var onSelectCoach: ((Coach) -> Void)? { get set }

}

class ChoosingCoachViewController: UIViewController, ChoosingCoach {
    
    var activity: TrainingType?
   
    @IBOutlet private weak var tableView: UITableView!
    
    private var coaches: [Coach] = []
    private var dataSource: CoachDataSource<ChoosingCoachTableViewCell>?
    
    var onSelectCoach: ((Coach) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Coaches"
        setupTableView()
        loadCoaches()
    }
    
    private func setupTableView() {
        dataSource = CoachDataSource<ChoosingCoachTableViewCell>(coaches: [])
        tableView.register(ChoosingCoachTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    private func loadCoaches() {
        guard let id = activity?.id else { return }
        startLoading()
        PMFightApi.shared.coaches(with: id) { [weak self] result in
            self?.endLoading()
            switch result {
            case .success(let coaches):
                self?.coaches = coaches
                guard let indexes = self?.dataSource?.append(items: coaches),
                      !indexes.isEmpty else { return }
                self?.tableView.insertRows(at: indexes, with: .none)
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
}

extension ChoosingCoachViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard coaches.indices.contains(indexPath.row) else { return }
        let coach = coaches[indexPath.row]
        onSelectCoach?(coach)
    }
}
