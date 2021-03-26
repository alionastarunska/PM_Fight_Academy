//
//  ActivityViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 25.03.2021.
//

import UIKit

protocol Activity: UIViewController {

    var onActivityStartBooking: (() -> Void)? { get set }
    var closeCoordinator: VoidClosure? {get set}

}

class ActivityViewController: UIViewController, Activity, NibLoadable {
    var closeCoordinator: VoidClosure?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var activityService = ActivityService()
    private var dataSource: ActivityDataSource<ActivityCollectionViewCell>?

    private var activityClientApi: ActivityClientAPI?
//    private var prefetchingService: ActivityDataSource?
    
    var onActivityStartBooking: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activity"

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"),
                                                            style: UIBarButtonItem.Style.done,
                                                            target: self,
                                                            action: #selector(addActivity))
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        self.collectionView.register(ActivityCollectionViewCell.nib, forCellWithReuseIdentifier: ActivityCollectionViewCell.name)

        self.collectionView.delegate = self
        
//        self.prefetchingService = PrefetchingDataSourceService()
        
        self.activityClientApi = ActivityClientAPI()
    
        self.collectionView.prefetchDataSource = dataSource
        
        
        activityClientApi?.fetchData(for: 1)
        
        
        PMFightApi.shared.incomingActivities(page: 1) { [weak self] result in
            switch result {
            case .success(let response):
                print(response.paggination)
                print(response.contents)
//                self?.dataSource = ActivityDataSourse<ActivityCollectionViewCell>(activities: avtivities)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.closeCoordinator?()
                }
            }
        }
        
//        let avtivities = activityService.getActivities(page: 0)
        
        
        self.collectionView.dataSource = dataSource
    }
    
    @objc
    private func addActivity() {
        onActivityStartBooking?()
    }
}

// MARK: Layout

extension ActivityViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width * 0.9
        let height = view.bounds.height * 0.147
        return CGSize(width: width, height: height)
        
    }
}

protocol FetchCompletable {
    associatedtype T
    
    func onFetchCompleted(with indexPathsToReload: [IndexPath], and models: [T])
}

extension ActivityViewController: FetchCompletable {
    
    func onFetchCompleted(with indexPathsToReload: [IndexPath], and models: [ActivityModel]) {
        
        self.dataSource?.activities = models
        
        collectionView.performBatchUpdates( {
            self.collectionView.insertItems(at: indexPathsToReload)
        }, completion: nil)
        
    }
    
    
}
