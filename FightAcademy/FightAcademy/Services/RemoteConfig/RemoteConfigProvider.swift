//
//  RemoteConfigProvider.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

struct RemoteConfigProvider {
    
    static func fetchSocialNetworks() -> [SocialNetwork] {

        let keys = RCKey.SocialNetworks.allCases.map { $0.rawValue }

        let pairs = keys
            .map { ($0, RemoteConfigManager.fetch(for: $0)) }
            .compactMap { $0 as? (String, String) }
            .filter { !$0.1.isEmpty }

        let socialNetworks = pairs.map { SocialNetwork(name: $0.0, link: $0.1) }
        
        return socialNetworks
    }

    static func fetchDescription() -> String {
        
        return RemoteConfigManager.fetch(for: RCKey.description.rawValue) ?? ""
    }

    static func fetchArticle() -> String {
        
        return RemoteConfigManager.fetch(for: RCKey.article.rawValue) ?? ""
    }
    
}
