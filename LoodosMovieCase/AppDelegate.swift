//
//  AppDelegate.swift
//  LoodosMovieCase
//
//  Created by Abdülbaki Kaplan on 13.06.2020.
//  Copyright © 2020 Baki. All rights reserved.
//

import UIKit
import Firebase
import PKHUD
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let _ = RCValues.shared

        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        setUpStartView()
        return true
    }
    
    func setUpStartView() {

        let splashVC = SplashVC(nibName: "SplashVC", bundle: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }


}

