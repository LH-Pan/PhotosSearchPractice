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
            
            let navigationController = UINavigationController()
            
            let mainView = SearchViewController(nibName: nil, bundle: nil)
            
            navigationController.viewControllers = [mainView]
            
            navigationController.navigationBar.backgroundColor = .navigationGray
            
            navigationController.navigationBar.isTranslucent = false
            
            window.rootViewController = navigationController
            
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "PhotosSearchPractice")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
