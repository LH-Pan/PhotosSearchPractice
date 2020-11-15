import Foundation

class ResultViewModel {

    // MARK: - Private Constant / Variable Declare
    private var page: Int = 1

    private let searchItem: String

    private let limit: Int

    private let photosProvider: PhotosProvider

    private var photos: [Photo] = []

    private var resultCellViewModels: [ResultCellViewModel] = [] {
        
        didSet {
            
            if resultCellViewModels.count > oldValue.count {
                
                insertCellsClosure?(resultCellViewModels, oldValue)
                
            } else if resultCellViewModels.count < oldValue.count {
                
                reloadDataClosure?()
            }
        }
    }
    
    // MARK: - Public Constant / Variable Declare
    var searchItemText: String {

        searchItem
    }
    
    var numberOfCells: Int {
        
        resultCellViewModels.count
    }
    
    // MARK: - Closure Declare
    var insertCellsClosure: ((_ newCells: [ResultCellViewModel], _ oldCells: [ResultCellViewModel]) -> Void)?
    
    var reloadDataClosure: (() -> Void)?

    // MARK: - Initialize Method
    init(searchItem: String, limit: Int) {

        self.searchItem = searchItem

        self.limit = limit

        photosProvider = PhotosProvider()
    }

    // MARK: - Public Method
    func initViewModel() {

        fetchPhotos()
    }

    func fetchPhotos(isRefreshing: Bool = false) {

        photosProvider.fetchPhotos(page: page, limit: limit, text: searchItem) { [weak self] result in

            guard let strongSelf = self else { return }

            switch result {

            case .success(let response):

                if response.data.totalPages > strongSelf.page { strongSelf.page += 1 }

                strongSelf.photos = isRefreshing ? response.data.photos : strongSelf.photos + response.data.photos
                
                strongSelf.processPhotosData(photos: response.data.photos, isRefreshing: isRefreshing)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func getCellViewModel(at index: Int) -> ResultCellViewModel {
        
        return resultCellViewModels[index]
    }
    
    func refreshFetchPhotos() {
        
        page = 1
        
        fetchPhotos(isRefreshing: true)
    }
    
    func didSelectedFavorite(at index: Int, imageData: Data?) {
        
        resultCellViewModels[index].isFavorite.toggle()
        
        let favoritePhoto = convertToFavoritePhoto(cellViewModel: resultCellViewModels[index],
                                                   imageData: imageData)
        
        if resultCellViewModels[index].isFavorite {
            
            StorageManager.shared.saveFavoritePhoto(favoritePhoto: favoritePhoto)
            
        } else {
            
            StorageManager.shared.deleteFavoritePhoto(photoID: favoritePhoto.id)
        }
    }
    
    // MARK: - Private Method
    private func processPhotosData(photos: [Photo], isRefreshing: Bool) {
        
        var cellVMs: [ResultCellViewModel] = []
        
        for photo in photos {
            
            cellVMs.append(createResultCellViewModel(photo: photo))
        }
        
        self.resultCellViewModels = isRefreshing ? cellVMs : self.resultCellViewModels + cellVMs
    }
    
    private func createResultCellViewModel(photo: Photo) -> ResultCellViewModel {
        
        let cellVM = ResultCellViewModel(id: Int(photo.id) ?? 0,
                                         imageUrlText: photo.photoUrlString,
                                         titleText: photo.title)
        return cellVM
    }
    
    private func convertToFavoritePhoto(cellViewModel: ResultCellViewModel, imageData: Data?) -> FavoritePhoto {
        
        let favoritePhoto = FavoritePhoto(id: cellViewModel.id,
                                          title: cellViewModel.titleText,
                                          photoData: imageData,
                                          createTime: Date().timeIntervalSince1970)
        
        return favoritePhoto
    }
}
