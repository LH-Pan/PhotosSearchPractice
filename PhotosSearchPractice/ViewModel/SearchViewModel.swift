import Foundation

class SearchViewModel {
    
    // MARK: - Private Constant / Variable Declare
    private var searchItemText: String = .empty {
        
        didSet {
            
            if searchItemText == .empty { return }
            
            changeState()
        }
    }
    
    private var limitText: String = .empty {
        
        didSet {
            
            if limitText == .empty {
                
                state = .disAllowSearch
                
                return
            }
            
            if !isNumber(text: limitText) {
                
                notNumberAlertClosure?()
                
            } else {
                
                changeState()
            }
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
    
    var state: SearchViewState = .disAllowSearch {
        
        didSet {
            
            if state == oldValue { return }
            
            changeStateClosure?(state)
        }
    }
    
    // MARK: - Closure Declare
    var notNumberAlertClosure: (()->())?
    
    var changeStateClosure: ((SearchViewState)->())?
    
    // MARK: - Public Method
    func initViewModel() {
        
        changeState()
    }
    
    func setSearchItem(text: String?) {
        
        searchItemText = text ?? .empty
    }
    
    func setLimit(text: String?) {
        
        limitText = text ?? .empty
    }
    
    // MARK: - Private Method
    private func isNumber(text: String?) -> Bool {
        
        Double(text ?? .empty) != nil
    }
    
    private func changeState() {
        
        state = (searchItemText != .empty && limitText != .empty) ? .allowSearch : .disAllowSearch
    }
}
