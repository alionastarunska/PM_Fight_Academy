//
//  AboutViewController.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

class AboutViewController: UIViewController, NibLoadable {

    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var articleTextView: UITextView!
    @IBOutlet private weak var facebookButton: UIButton!
    @IBOutlet private weak var youtubeButton: UIButton!
    @IBOutlet private weak var instagramButton: UIButton!
    @IBOutlet private  weak var phoneButton: UIButton!
    @IBOutlet private weak var adressLabel: UILabel!
    
    private let descriptionText: String
    private let articleText: String
    private let phoneNumber: String
    private let adress: String
    
    private var socialNetworks: [SocialNetwork]

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adressLabel.text = adress
        phoneButton.setTitle(phoneNumber, for: .normal)
        makeSetUps()
    }

    init(socialNetworks: [SocialNetwork], description: String, acticle: String, phoneNumber: String, adress: String) {
        self.socialNetworks = socialNetworks
        descriptionText = description
        articleText = acticle
        self.phoneNumber = phoneNumber
        self.adress = adress
        super.init(nibName: Self.name, bundle: .main)
    }

    required init?(coder: NSCoder) {
        socialNetworks = []
        descriptionText = ""
        articleText = ""
        phoneNumber = ""
        adress = ""
        super.init(nibName: Self.name, bundle: .main)
    }
    
    // MARK: - Actions
    
    @IBAction private func facebookButtonAction(_ sender: UIButton) {
        guard let facebook = socialNetworks.first(where: { $0.name == .facebook }) else { return }
        open(link: facebook.link)
    }
    
    @IBAction private func youtubeButtonAction(_ sender: UIButton) {
        guard let youtube = socialNetworks.first(where: { $0.name == .youtube }) else { return }
        open(link: youtube.link)
    }
    
    @IBAction private func instagramButtonAction(_ sender: UIButton) {
        guard let instagram = socialNetworks.first(where: { $0.name == .instagram }) else { return }
        open(link: instagram.link)
    }

    @IBAction private func phoneAction(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
           UIApplication.shared.open(number)
    }
}

private extension AboutViewController {

    func makeSetUps() {
        navigationItem.title = "About"
        setupAcricles()
    }

    func setupAcricles() {
        descriptionTextView.text = descriptionText
        articleTextView.text = articleText
    }
    
    func open(link: String) {
        guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

private extension String {
    static var instagram: String { return "instagram" }
    static var facebook: String { return "facebook" }
    static var youtube: String { return "youtube" }
}
