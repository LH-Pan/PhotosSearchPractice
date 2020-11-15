import UIKit

class PSNavigationController: UINavigationController {
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            
            navigationBar.barTintColor = .navigationGray
            
        } else {
            
            navigationBar.backgroundColor = .navigationGray
        }
        
        navigationBar.isTranslucent = false
    }
}
