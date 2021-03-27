//
//  RemoteConfigManager.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation
import FirebaseRemoteConfig

struct RemoteConfigManager {

    private static var remoteConfig: RemoteConfig = {
        var remoteConfig = RemoteConfig.remoteConfig()

        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")

        return remoteConfig
    }()

    static func configure(expirationDuration: TimeInterval = 3600.0) {
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { (_, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            RemoteConfig.remoteConfig().activate(completion: nil)
        }
    }

    static func fetch(for key: String) -> String? {
        return remoteConfig.configValue(forKey: key).stringValue
    }

}
