import UIKit
import IQKeyboardManagerSwift

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        
        let navigationController = UINavigationController()
        
        let mainView = SearchViewController(nibName: nil, bundle: nil)
        
        navigationController.viewControllers = [mainView]
        
        navigationController.navigationBar.barTintColor = .navigationGray

        navigationController.navigationBar.isTranslucent = false
        
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
