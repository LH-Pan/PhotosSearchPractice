import Foundation

class SearchViewModel {
    
    // MARK: - Private Constant / Variable Declare
    private var searchItemText: String = .empty {
        
        didSet {
            
            changeState()
        }
    }
    
    private var limitText: String = .empty {
        
        didSet {
                
            changeState()
        }
    }
    
    // MARK: - Public Constant / Variable Declare
    var searchItem: String {
        
        searchItemText
    }
    
    var limit: Int {
        
        guard let double = Double(limitText) else { return 0 }
        
        let floorInt = Int(floor(double))
        
        return floorInt
    }
    
    var state: SearchViewState = .disallowSearch {
        
        didSet {
            
            if state == oldValue { return }
            
            changeStateClosure?(state)
        }
    }
    
    // MARK: - Closure Declare
    var notNumberAlertClosure: (() -> Void)?
    
    var changeStateClosure: ((SearchViewState) -> Void)?
    
    // MARK: - Initialize Method
    init() {
        
        changeState()
    }
    
    // MARK: - Public Method
    func setSearchItem(text: String?) {
        
        if text == .empty { return }
        
        searchItemText = text ?? .empty
    }
    
    func setLimit(text: String?) {
        
        if text == .empty { return }
        
        if !isNumber(text: text) {
            
            notNumberAlertClosure?()
            
            state = .disallowSearch
            
            return
        }
        
        limitText = text ?? .empty
    }
    
    // MARK: - Private Method
    private func isNumber(text: String?) -> Bool {
        
        Double(text ?? .empty) != nil
    }
    
    private func changeState() {
        
        state = (searchItemText != .empty && limitText != .empty) ? .allowSearch : .disallowSearch
    }
}
