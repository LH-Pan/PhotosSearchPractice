//
//  AppDelegate.swift
//  PhotosSearchPractice
//
//  Created by 潘立祥 on 2020/11/13.
//  Copyright © 2020 PanLiHsiang. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            
        } else {
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            
            self.window = window
            
            let tabBarController: UITabBarController = PSTabBarController()
            
            window.rootViewController = tabBarController
            
            window.makeKeyAndVisible()
        }
        
        IQKeyboardManager.shared.enable = true
        
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
