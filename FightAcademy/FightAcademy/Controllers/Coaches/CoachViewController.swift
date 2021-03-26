//
//  CoachViewController.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 21.03.2021.
//

import UIKit

class CoachViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: CoachDataSource<CoachTableViewCell>?
    private var page: Int = 1
    private var canLoadMore: Bool = true
    private var isLoadingMore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Coach"
        
        setupTableView()
        loadMoreCoaches()
    }

    private func setupTableView() {
        dataSource = CoachDataSource<CoachTableViewCell>(coaches: [])
        tableView.register(CoachTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    private func loadMoreCoaches() {
        guard !isLoadingMore else { return }
        guard canLoadMore else { return }
        isLoadingMore = true
        page += 1
        PMFightApi.shared.getCoaches(page: page) { [weak self] result in
            self?.isLoadingMore = false
            switch result {
            case .success(let response):
                self?.canLoadMore = response.paggination.hasNextPage
                guard let indexes = self?.dataSource?.append(items: response.contents.map({ CoachCellModel(coach: $0) })),
                      !indexes.isEmpty else { return }
                self?.tableView.insertRows(at: indexes, with: .none)
            case .failure(let error):
                self?.page -= 1
                print(error)
            }
        }
    }
}

extension CoachViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == tableView.numberOfRows(inSection: 0) - 1 else { return }
        loadMoreCoaches()
    }
}
