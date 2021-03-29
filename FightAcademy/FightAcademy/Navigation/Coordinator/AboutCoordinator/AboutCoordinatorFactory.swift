//
//  AboutCoordinatorFactory.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/20/21.
//

import UIKit

protocol AboutFactoryProtocol {

    func makeAboutViewController() -> UIViewController

}

final class AboutFactory: AboutFactoryProtocol {

    func makeAboutViewController() -> UIViewController {

        let socialNetworks = RemoteConfigProvider.fetchSocialNetworks()
        let description = RemoteConfigProvider.fetchDescription()
        let acticle = RemoteConfigProvider.fetchArticle()
        let phoneNumber = RemoteConfigProvider.fetchPhoneNumber()
        let adress = RemoteConfigProvider.fetchAdress()

        return AboutViewController(socialNetworks: socialNetworks,
                                   description: description,
                                   acticle: acticle,
                                   phoneNumber: phoneNumber,
                                   adress: adress)
    }

}
