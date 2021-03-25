//
//  ChoosingCoachViewController.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

protocol ChoosingCoach: UIViewController {

    var onSelectCoach: ((Coach) -> Void)? { get set }

}

class ChoosingCoachViewController: UIViewController, ChoosingCoach {
   
    @IBOutlet private weak var tableView: UITableView!
    
    private var coaches: [Coach] = CoachMock.make()
    private var dataSource: CoachDataSource<ChoosingCoachTableViewCell>?
    
    var onSelectCoach: ((Coach) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Coaches"
        setupTableView()
    }
    
    private func setupTableView() {
        dataSource = CoachDataSource<ChoosingCoachTableViewCell>(coaches: coaches)
        tableView.register(ChoosingCoachTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

}

extension ChoosingCoachViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard coaches.indices.contains(indexPath.row) else { return }
        let coach = coaches[indexPath.row]
        onSelectCoach?(coach)
    }
}
