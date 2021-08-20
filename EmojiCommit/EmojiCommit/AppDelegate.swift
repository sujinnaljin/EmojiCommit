//
//  AppDelegate.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/03/22.
//

import Firebase
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Use Firebase library to configure APIs.
        FirebaseApp.configure()
        
        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}
