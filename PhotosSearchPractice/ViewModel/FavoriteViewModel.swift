import Foundation

class FavoriteViewModel {
    
    // MARK: - Private Constant / Variable Declare
    private var photoObserver: NSKeyValueObservation!
    
    private var favoriteCellViewModels: [FavoriteCellViewModel] = [] {
        
        didSet {
            
            reloadDataClosure?()
        }
    }
    
    // MARK: - Public Constant / Variable Declare
    
    var numberOfCells: Int {
        
        favoriteCellViewModels.count
    }
    
    // MARK: - Closure Declare
    
    var reloadDataClosure: (() -> Void)?
    
    // MARK: - Initialize Method
    init() {
        
        addObserver()
    }
    
    // MARK: - Public Method
    
    func initViewModel() {
        
        fetchPhotos()
    }
    
    func getCellViewModel(at index: Int) -> FavoriteCellViewModel {
        
        favoriteCellViewModels[index]
    }
    
    // MARK: - Private Method
    private func addObserver() {
        
        photoObserver = StorageManager.shared.observe(
            \.favoritePhotos,
            options: .new,
            changeHandler: { [weak self] _, change in
                
                guard let newValue = change.newValue else { return }
                
                self?.processDataFromStorageManager(newValue)
        })
    }
    
    private func fetchPhotos() {
        
        StorageManager.shared.fetchFavoritePhotos()
    }
    
    private func processDataFromStorageManager(_ lsFavoritePhotos: [LSFavoritePhoto]) {
        
        var cellViewModels: [FavoriteCellViewModel] = []
        
        for lsFavoritePhoto in lsFavoritePhotos {
            
            cellViewModels.append(createFavoriteCellViewModel(lsFavoritePhoto))
        }
        
        self.favoriteCellViewModels = cellViewModels
    }
    
    private func createFavoriteCellViewModel(_ lsFavoritePhoto: LSFavoritePhoto) -> FavoriteCellViewModel {
        
        let cellVM = FavoriteCellViewModel(title: lsFavoritePhoto.title ?? .empty,
                                           photoData: lsFavoritePhoto.photoData)
        
        return cellVM
    }
}
