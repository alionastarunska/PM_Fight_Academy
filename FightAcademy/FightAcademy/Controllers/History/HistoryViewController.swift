//
//  HistoryViewController.swift
//  FightAcademy
//
//  Created by Павел Снижко on 26.03.2021.
//

import UIKit

class HistoryViewController: UIViewController, NibLoadable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "History"
    }

}
