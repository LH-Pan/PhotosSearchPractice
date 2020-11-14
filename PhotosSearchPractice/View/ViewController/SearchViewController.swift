import UIKit
import SnapKit

enum SearchViewState {
    
    case allowSearch
    
    case disAllowSearch
    
    var buttonEnable: Bool {
        
        switch self {
            
        case .allowSearch: return true
            
        case .disAllowSearch: return false
        }
    }
    
    var buttonBackgroundColor: UIColor {
        
        switch self {
            
        case .allowSearch: return .skyBlue
            
        case .disAllowSearch: return .placeHolderGray
        }
    }
}

class SearchViewController: UIViewController {
    
    // MARK: - Constant / Variable Declare
    lazy var viewModel: SearchViewModel = {

        let viewModel = SearchViewModel()

        return viewModel
    }()
    
    let searchItemTextField = PaddingTextField()
    
    let limitTextField = PaddingTextField()
    
    let searchButton = UIButton()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        
        setupSubViews()
        
        setupConstraints()
        
        bindWithVM()
    }
    
    // MARK: - Private Method
    private func bindWithVM() {
        
        viewModel.notNumberAlertClosure = { [weak self] in
            
            self?.presentNotNumberAlert()
        }
        
        viewModel.changeStateClosure = { [weak self] state in
            
            self?.setupSearchButton(with: state)
        }
        
        viewModel.initViewModel()
    }
    
    private func addSubViews() {
        
        view.addSubview(searchItemTextField)
        view.addSubview(limitTextField)
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
            keyBoardType: .numbersAndPunctuation
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
    
    private func setupSearchButton(with state: SearchViewState) {
        
        searchButton.isEnabled = state.buttonEnable
        
        searchButton.backgroundColor = state.buttonBackgroundColor
    }
    
    private func presentNotNumberAlert() {
        
        let alert = UIAlertController(title: "請輸入數字", message: "不可輸入非整數以外的字元", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: { [weak self] _ in
            
            self?.limitTextField.text = .empty
            
            self?.viewModel.setLimit(text: .empty)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Objc Method
    @objc private func pushToResultPage() {
        
        let resultViewModel = ResultViewModel()
        
        let nextVC = ResultViewController(nibName: nil, bundle: nil, viewModel: resultViewModel)
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - 實作 UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
            
        case searchItemTextField: viewModel.setSearchItem(text: textField.text)
        
        case limitTextField: viewModel.setLimit(text: textField.text)
            
        default: break
        }
    }
}
