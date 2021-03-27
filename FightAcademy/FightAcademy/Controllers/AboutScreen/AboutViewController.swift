//
//  AboutViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet private weak var table: AutoSizingTableView!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var articleTextView: UITextView!
    
    private let descriptionText: String
    private let articleText: String

    private let dataSourse: SocialNetworkDataSourse<AboutSocialTableCell>

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "About"

        setupTableView()
        setupAcricles()
    }

    private func setupAcricles() {
        descriptionTextView.text = descriptionText
        articleTextView.text = articleText
    }

    private func setupTableView() {
        table.register(AboutSocialTableCell.self)
        table.dataSource = dataSourse
    }

    init(socialNetworks: [SocialNetwork], description: String, acticle: String) {
        dataSourse = SocialNetworkDataSourse<AboutSocialTableCell>(items: socialNetworks)
        descriptionText = description
        articleText = acticle
        super.init(nibName: "AboutViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        dataSourse = SocialNetworkDataSourse<AboutSocialTableCell>(items: [])
        descriptionText = ""
        articleText = ""
        super.init(nibName: "AboutViewController", bundle: .main)
    }
    
}
