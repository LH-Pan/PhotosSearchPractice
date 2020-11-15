import UIKit

class PSNavigationController: UINavigationController {
    
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
