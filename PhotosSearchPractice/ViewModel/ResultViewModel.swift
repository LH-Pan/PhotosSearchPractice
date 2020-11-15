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
            
            reloadDateClosure?()
        }
    }
    
    // MARK: - Public Constant / Variable Declare
    var searchItemText: String {

        searchItem
    }
    
    var numberOfCells: Int {
        
        resultCellViewModels.count
    }
    
    var reloadDateClosure: (() -> Void)?

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

    func fetchPhotos() {

        photosProvider.fetchPhotos(page: page, limit: limit, text: searchItem) { [weak self] result in

            guard let strongSelf = self else { return }

            switch result {

            case .success(let response):

                if response.data.totalPages > strongSelf.page { strongSelf.page += 1 }

                strongSelf.photos += response.data.photos
       
                strongSelf.processPhotosData(photos: response.data.photos)
                
            case .failure(let error): print(error)
            }
        }
    }
    
    func getCellViewModel(at index: Int) -> ResultCellViewModel {
        
        return resultCellViewModels[index]
    }
    
    // MARK: - Private Method
    private func processPhotosData(photos: [Photo]) {
        
        var cellVMs: [ResultCellViewModel] = []
        
        for photo in photos {
            
            cellVMs.append(createResultCellViewModel(photo: photo))
        }
        
        self.resultCellViewModels += cellVMs
    }
    
    private func createResultCellViewModel(photo: Photo) -> ResultCellViewModel {
        
        let cellVM = ResultCellViewModel(imageUrlText: photo.photoUrlString,
                                         titleText: photo.title)
        return cellVM
    }
}
