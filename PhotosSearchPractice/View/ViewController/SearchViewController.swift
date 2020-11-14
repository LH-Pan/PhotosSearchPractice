import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
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
        
        setupTextFields()
        
        setupButton()
    }
    
    private func setupTextFields() {
        
        setupTextField(
            textField: searchItemTextField,
            title: "欲搜尋內容",
            padding: 8,
            borderWidth: 1,
            borderColor: .placeHolderGray,
            cornerRadius: 6
        )
        
        setupTextField(
            textField: limitTextField,
            title: "每頁呈現數量",
            padding: 8,
            borderWidth: 1,
            borderColor: .placeHolderGray,
            cornerRadius: 6,
            keyBoardType: .numberPad
        )
    }
    
    private func setupTextField(textField: PaddingTextField, title: String, padding: CGFloat, borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat, keyBoardType: UIKeyboardType = .default) {
        
        textField.delegate = self
        textField.placeholder = title
        textField.padding = padding
        textField.font = .systemFont(ofSize: 16, weight: .heavy)
        textField.keyboardType = keyBoardType
        
        textField.setupBorderAndRadius(
            borderWidth: borderWidth,
            borderColor: borderColor,
            cornerRadius: cornerRadius
        )
    }
    
    private func setupButton() {
        
        searchButton.setTitle("搜尋", for: .normal)
        
        searchButton.setTitleColor(.white, for: .normal)
        
        searchButton.showsTouchWhenHighlighted = true
        
        searchButton.backgroundColor = .placeHolderGray
        
        searchButton.isEnabled = false
        
        searchButton.addTarget(self, action: #selector(pushToResultPage), for: .touchUpInside)
    }
    
    // MARK: - Objc Method
    @objc private func pushToResultPage() {
        
        print(111)
    }
}

// MARK: - 實作 UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
            
        case limitTextField: break
            
        case searchItemTextField: break
            
        default: break
        }
    }
}
