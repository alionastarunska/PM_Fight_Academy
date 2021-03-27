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
  
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
        
    private var dataSource: ActivityDataSource<ActivityCollectionViewCell>?

    private var activityClientApi: ActivityClientAPI?
    
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
                
        self.activityClientApi = ActivityClientAPI()
        
        self.handleResponseFromAPI()
        
        self.activityClientApi?.fetchData()
        
        self.dataSource = ActivityDataSource(apiCaller: activityClientApi)
        
        self.collectionView.prefetchDataSource = dataSource
        self.collectionView.dataSource = dataSource
    }
    
    func handleResponseFromAPI() {
        
        startActivityIndicator()
        
        self.activityClientApi?.fetchCompleted = { [weak self]  result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let successeData):
                guard  let successeData = successeData else {
                    print("successeData == nil")
                    return
                }
                            
                self.endActivityIndicator()
                
                self.collectionView.performBatchUpdates({
                    self.dataSource?.activities = successeData.1
                    self.collectionView.insertItems(at: successeData.0)
                }, completion: nil)
                
            case .failure(let error):
                print("ERROR " + error.localizedDescription)
                
                DispatchQueue.main.async {
                    self.closeCoordinator?()
                }
            }
        }
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

private extension ActivityViewController {
    
    func startActivityIndicator() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.stopAnimating()
    }
    
    func endActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
}
