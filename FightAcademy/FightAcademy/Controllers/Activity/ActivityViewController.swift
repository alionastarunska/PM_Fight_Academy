//
//  ActivityViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 25.03.2021.
//

import UIKit

protocol Activity: UIViewController {

    var onActivityStartBooking: (() -> Void)? { get set }

}

class ActivityViewController: UIViewController, Activity, NibLoadable {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var activityService = ActivityService()
    private var dataSource: ActivityDataSourse<ActivityCollectionViewCell>?

    private var prefetchingService: PrefetchingDataSourceService?
    
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
        
        self.prefetchingService = PrefetchingDataSourceService()
        
        self.collectionView.prefetchDataSource = prefetchingService
        
        let avtivities = activityService.getActivities(page: 0)
        self.dataSource = ActivityDataSourse<ActivityCollectionViewCell>(activities: avtivities)
        
        self.collectionView.dataSource = self.dataSource
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
