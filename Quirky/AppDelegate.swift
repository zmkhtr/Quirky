//
//  AppDelegate.swift
//  Quirky
//
//  Created by Azam Mukhtar on 08/06/20.
//  Copyright © 2020 Azam Mukhtar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let displayStatusChanged: CFNotificationCallback = { center, observer, name, object, info in
        let str = name!.rawValue as CFString
        if (str == "com.apple.springboard.lockcomplete" as CFString) {
            let isDisplayStatusLocked = UserDefaults.standard
            isDisplayStatusLocked.set(true, forKey: "isDisplayStatusLocked")
            isDisplayStatusLocked.synchronize()
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
          let isDisplayStatusLocked = UserDefaults.standard
          isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
          isDisplayStatusLocked.synchronize()
          
          // Darwin Notification
          let cfstr = "com.apple.springboard.lockcomplete" as CFString
          let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
          let function = displayStatusChanged
          CFNotificationCenterAddObserver(notificationCenter,
                                          nil,
                                          function,
                                          cfstr,
                                          nil,
                                          .deliverImmediately)
          
          return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

