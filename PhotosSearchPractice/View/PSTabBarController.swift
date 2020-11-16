import UIKit

class PSTabBarController: UITabBarController {
    
    enum Navigation: Int {
        
        case featured = 0
        
        case favorite = 1
        
        var rootVC: UIViewController {
            
            switch self {
                
            case .featured: return SearchViewController()
                
            case .favorite: return FavoriteViewController()
            }
        }
        
        var tabBarTitle: String {
            
            switch self {
                
            case .featured: return "Featured"
                
            case .favorite: return "Favorite"
            }
        }
        
        var tabBarImageName: String {
            
            switch self {
                
            case .featured, .favorite: return "star.fill"
            }
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarViewControllers()
    }
    
    // MARK: - Private Method
    private func setupTabBarViewControllers() {
        
        self.viewControllers = [setupNavigationController(navigation: .featured),
                                setupNavigationController(navigation: .favorite)]
    }
    
    private func setupNavigationController(navigation: Navigation) -> UINavigationController {

        let viewController = navigation.rootVC

        let navigationController = PSNavigationController(rootViewController: viewController)

        let item = UITabBarItem(title: navigation.tabBarTitle,
                                image: UIImage(systemName: navigation.tabBarImageName),
                                tag: navigation.rawValue)

        navigationController.tabBarItem = item

        return navigationController
    }
}
