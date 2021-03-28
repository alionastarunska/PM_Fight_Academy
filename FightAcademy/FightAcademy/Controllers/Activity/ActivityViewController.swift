//
//  ActivityViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 25.03.2021.
//

import UIKit

protocol Activity: UIViewController {

    var onActivityStartBooking: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }

}

class ActivityViewController: UIViewController, Activity, NibLoadable {

    var onActivityStartBooking: (() -> Void)?
    var onError: ((Error) -> Void)?

    @IBOutlet weak var tableView: UITableView!

    private var tableManager = TableViewManager<ActivityTableViewCell>()
    private let activityService: ActivityService

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activity"
        setUpCollectionView()

        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "plus"),
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(addActivity))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performFetch()
    }
    
    init(activityService: ActivityService) {
        self.activityService = activityService
        super.init(nibName: Self.name, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension ActivityViewController {

    func setUpCollectionView() {
        tableView.registerNib(for: ActivityTableViewCell.self)


    }

    func performFetch(page: Int = 1) {
        
        if page == 1 {
            setManager()
        }

        tableManager.onRowsEnded = { [weak self] in
            self?.performFetch(page: page + 1)
        }

        activityService.incomingActivities(page: page, completion: validateFetchResult)
    }

    func setManager() {
        tableManager = TableViewManager()
        tableView.dataSource = tableManager
        tableView.delegate = tableManager
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

    @objc
    private func addActivity() {
        onActivityStartBooking?()
    }

}
