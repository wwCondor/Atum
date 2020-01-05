//
//  AppDelegate.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = UIColor(named: .objectColor) // NavBar background color
        navigationBarAppearance.tintColor = UIColor(named: .iconColor)
        navigationBarAppearance.isTranslucent = false
        
        // Gets rid of shadow under navBar
        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.setBackgroundImage(UIImage(), for: .default)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: RoverViewController())
        
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

/*
 
 Performance Testing:
    1. Memory Graph Debugger:
        - No runtime issues identified
    2. Memory Management:
        - Enabled Malloc Stack for Live Allocations showed no issues
    3. Image Loading Time:
        - The loading time for the images took considerable time. In fact to long to make a good user experience.
            Fix 1: The API call retrieving the BlueMarblePhotos has been switched from .png to a .jpg query.
            Fix 2: The images retrieved from various endpoints are reduced to a smaller size before loaded into the UIImageViews.
 
 */
