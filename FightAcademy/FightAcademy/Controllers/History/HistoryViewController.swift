//
//  HistoryViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 26.03.2021.
//

import UIKit

//TODO: Probably it can be better think about inheritance or smth else

class HistoryViewController: UIViewController, NibLoadable, UICollectionViewDelegate {
    
    var closeCoordinator: VoidClosure?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var dataSource: HistoryDataSource<HistoryCollectionViewCell>?
    
    var historyClientApi: HistoryClientApi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "History"
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        self.collectionView.register(HistoryCollectionViewCell.nib, forCellWithReuseIdentifier: HistoryCollectionViewCell.name)
        
        self.collectionView.delegate = self
        
        self.historyClientApi = HistoryClientApi()
        
        self.handleResponseFromAPI()
        
        self.historyClientApi?.fetchData()
        
        self.dataSource = HistoryDataSource(apiCaller: historyClientApi)
        
        self.collectionView.prefetchDataSource = dataSource
        self.collectionView.dataSource = dataSource
    }
    
    func handleResponseFromAPI() {
        
        startActivityIndicator()
        
        self.historyClientApi?.fetchCompleted = { [weak self]  result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let successeData):
                guard  let successeData = successeData else {
                    print("successeData == nil")
                    return
                }
                
                print(successeData)
                self.endActivityIndicator()
                
                self.collectionView.performBatchUpdates({
                    self.dataSource?.trainings = successeData.1
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
    
}


extension HistoryViewController {
    func startActivityIndicator() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.stopAnimating()
    }
    
    func endActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
}
