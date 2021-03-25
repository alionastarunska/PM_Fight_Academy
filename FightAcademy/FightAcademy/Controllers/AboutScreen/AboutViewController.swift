//
//  AboutViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet private weak var table: AutoSizingTableView!
    
    private var socialNetworks: [SocialNetwork] = [.init(name: "facebook",
                                                         link: "https://facebook.com"),
                                                   .init(name: "instagram",
                                                         link: "https://instagram.com"),
                                                   .init(name: "youtube",
                                                         link: "https://youtube.com")]

    private var dataSourse: SocialNetworkDataSourse<AboutSocialTableCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "About"
        
        setupTableView()
    }

    private func setupTableView() {
        dataSourse = SocialNetworkDataSourse<AboutSocialTableCell>(items: socialNetworks)
        table.register(AboutSocialTableCell.self)
        table.dataSource = dataSourse
    }

    init() {
        super.init(nibName: "AboutViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: "AboutViewController", bundle: .main)
    }
    
}
