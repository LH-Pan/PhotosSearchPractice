import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - Private Constant / Variable Declare
    private let viewModel: ResultViewModel
    
    // MARK: - Initialize Method
    init(viewModel: ResultViewModel) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        bindWithVM()
    }
    
    // MARK: - Private Method
    private func bindWithVM() {
        
        viewModel.initViewModel()
    }
}
