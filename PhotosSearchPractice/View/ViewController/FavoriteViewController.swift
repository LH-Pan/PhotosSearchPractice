import UIKit

class FavoriteViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "我的最愛"
        
        view.backgroundColor = .white
    }
}
