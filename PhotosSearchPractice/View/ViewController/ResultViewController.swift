import UIKit

class ResultViewController: UIViewController {
    
    let viewModel: ResultViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .skyBlue
    }
    
    init(nibName: String?, bundle: Bundle?, viewModel: ResultViewModel) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
