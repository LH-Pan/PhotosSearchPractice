import UIKit
import SnapKit

class PhotosSearchViewController: UIViewController {
    
    // MARK: - Constant / Variable Declare
    let searchItemTextField = PaddingTextField()
    
    let limitTextField = PaddingTextField()
    
    let searchButton = UIButton()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        
        setupSubViews()
        
        setupConstraints()
    }
    
    // MARK: - Private Method
    
    private func addSubViews() {
        
        view.addSubview(limitTextField)
        view.addSubview(searchItemTextField)
        view.addSubview(searchButton)
    }
    
    private func setupConstraints() {
        
        limitTextField.snp.makeConstraints { make in
            
            make.center.equalTo(view)
            make.width.equalTo(CGFloat(350).convertWithSimulatorWidth())
            make.height.equalTo(CGFloat(35).convertWithSimulatorHeight())
        }
        
        searchItemTextField.snp.makeConstraints { make in
            
            make.size.equalTo(limitTextField)
            make.centerX.equalTo(limitTextField)
            make.bottom.equalTo(limitTextField.snp.top).offset(CGFloat(-25).convertWithSimulatorHeight())
        }
        
        searchButton.snp.makeConstraints { make in
            
            make.size.equalTo(limitTextField)
            make.centerX.equalTo(limitTextField)
            make.top.equalTo(limitTextField.snp.bottom).offset(CGFloat(25).convertWithSimulatorHeight())
        }
    }
    
    private func setupSubViews() {
        
        title = "搜尋輸入頁"
        
        view.backgroundColor = .white
        
        setupTextField()
        
        setupButton()
    }
    
    private func setupTextField() {
        
        limitTextField.placeholder = "每頁呈現數量"
        limitTextField.padding = 8
        limitTextField.setupBorderAndRadius(borderWidth: 1, borderColor: .lightGray, cornerRadius: 6)
        
        searchItemTextField.placeholder = "欲搜尋內容"
        searchItemTextField.padding = 8
        searchItemTextField.setupBorderAndRadius(borderWidth: 1, borderColor: .lightGray, cornerRadius: 6)
    }
    
    private func setupButton() {
        
        searchButton.setTitle("搜尋", for: .normal)
        
        searchButton.setTitleColor(.white, for: .normal)
        
        searchButton.showsTouchWhenHighlighted = true
        
        searchButton.backgroundColor = .blue
        
        searchButton.isEnabled = true
        
        searchButton.addTarget(self, action: #selector(pushToResultPage), for: .touchUpInside)
    }
    
    @objc private func pushToResultPage() {
        
        print(111)
    }
}

