//
//  RCValues.swift
//  LoodosMovieCase
//
//  Created by Abdülbaki Kaplan on 13.06.2020.
//  Copyright © 2020 Baki. All rights reserved.
//

import Foundation
import Firebase
import FirebaseRemoteConfig

enum ValueKey: String {
  case welcomeMessage
}

class RCValues {

    static let shared = RCValues()
    
    var loadingDoneCallback: (() -> Void)?
    var fetchComplete = false

    private init() {
      loadDefaultValues()
    }

    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            ValueKey.welcomeMessage.rawValue : ""
        ]
      
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
        fetchCloudValues()
    }

    func fetchCloudValues() {
        RemoteConfig.remoteConfig().fetchAndActivate { [weak self] status, error in

            if let error = error {
                print ("Got an error fetching remote values \(error)")
                return
            }

            print ("Retrieved values from the cloud!")

            self?.fetchComplete = true
            self?.loadingDoneCallback?()
        }
    }
    
    func string(forKey key: ValueKey) -> String {
        return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }
}

