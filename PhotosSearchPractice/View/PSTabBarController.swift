import UIKit

class PSTabBarController: UITabBarController {

    // MARK: - Private Constant / Variable Declare
    private var tag: Int = 0
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarViewControllers()
    }
    
    // MARK: - Private Method
    private func setupTabBarViewControllers() {
        
        let featuredNavigationController = setupNavigationController(rootVC: SearchViewController(),
                                                                     tabBarTitle: "Featured")
        
        let favoriteNavigationController = setupNavigationController(rootVC: FavoriteViewController(),
                                                                     tabBarTitle: "Favorite")
        
        self.viewControllers = [featuredNavigationController, favoriteNavigationController]
    }
    
    private func setupNavigationController(rootVC: UIViewController,
                                           tabBarTitle: String,
                                           tabBarImageName: String = "star.fill"
                                           ) -> UINavigationController {
        
        let viewController = rootVC
        
        let navigationController = PSNavigationController(rootViewController: viewController)
        
        let item = UITabBarItem(title: tabBarTitle, image: UIImage(systemName: tabBarImageName), tag: tag)
        
        navigationController.tabBarItem = item
        
        tag += 1
        
        return navigationController
    }
}
