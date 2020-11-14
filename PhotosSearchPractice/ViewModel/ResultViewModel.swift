import Foundation

class ResultViewModel {
    
    // MARK: - Private Constant / Variable Declare
    private var page: Int = 1
    
    private let searchItem: String
    
    private let limit: Int
    
    private let photosProvider: PhotosProvider
    
    // MARK: - Initialize Method
    init(searchItem: String, limit: Int) {
        
        self.searchItem = searchItem
        
        self.limit = limit
        
        photosProvider = PhotosProvider()
    }
    
    // MARK: - Public Method
    func initViewModel() {
        
        photosProvider.fetchPhotos(page: page, limit: limit, text: searchItem) { result in
            
            switch result {
                
            case .success(let data): print(data)
                
            case .failure(let error): print(error)
            }
        }
    }
}
