//
//  HistoryViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 26.03.2021.
//

import UIKit

class HistoryViewController: UIViewController, NibLoadable, UICollectionViewDelegate {

    var onError: ((Error) -> Void)?

    @IBOutlet weak var tableView: UITableView!

    private var tableManager = TableViewManager<HistoryTableViewCell>()
    private let historyService: HistoryService

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "History"
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        performFetch()
    }

    init(historyService: HistoryService) {
        self.historyService = historyService
        super.init(nibName: Self.name, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension HistoryViewController {

    func setUpCollectionView() {
        tableView.registerNib(for: HistoryTableViewCell.self)

        tableView.dataSource = tableManager
        tableView.delegate = tableManager

    }

    func performFetch(page: Int = 1) {

        tableManager.onRowsEnded = { [weak self] in
            self?.performFetch(page: page + 1)
        }

        historyService.activityHistory(page: page, completion: validateFetchResult)

    }

    func validateFetchResult(_ result: Result<ApiResponse<Training>, Error>) {

        do {

            let apiResponce = try result.get()

            let indices = tableManager.append(items: apiResponce.contents)

            tableView.insertRows(at: indices, with: .none)

        } catch {
            onError?(error)
        }

    }

}
