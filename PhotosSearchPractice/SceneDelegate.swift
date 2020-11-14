//
//  SceneDelegate.swift
//  PhotosSearchPractice
//
//  Created by 潘立祥 on 2020/11/13.
//  Copyright © 2020 PanLiHsiang. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        
        let navigationController = UINavigationController()
        
        let mainView = PhotosSearchViewController(nibName: nil, bundle: nil)
        
        navigationController.viewControllers = [mainView]
        
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
    }
}

