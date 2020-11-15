import CoreData

typealias LSFavoritePhotoResults = (Result<[LSFavoritePhoto], Error>) -> Void

@objc class StorageManager: NSObject {
    
    enum Entity: String {
        
        case favoritePhoto = "LSFavoritePhoto"
    }
    
    static let shared = StorageManager()
    
    private override init() {
        
        print("Core data file path: \(NSPersistentContainer.defaultDirectoryURL())")
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "PhotosSearchPractice")
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        
        return persistentContainer.viewContext
    }
    
    @objc dynamic var favoritePhotos: [LSFavoritePhoto] = []
    
    func fetchFavoritePhotos(completion: LSFavoritePhotoResults? = nil) {

        let request = NSFetchRequest<LSFavoritePhoto>(entityName: Entity.favoritePhoto.rawValue)

        do {

            let photos = try viewContext.fetch(request)
            
            self.favoritePhotos = photos.sorted(by: { $0.createTime < $1.createTime })

            completion?(Result.success(photos))

        } catch {

            completion?(Result.failure(error))
        }
    }
    
    func saveFavoritePhoto(favoritePhoto: FavoritePhoto, completion: (Result<Void, Error>) -> Void) {

        let lsFavoritePhoto = LSFavoritePhoto(context: viewContext)

        lsFavoritePhoto.mapping(favoritePhoto)

        do {

            try viewContext.save()

            completion(Result.success(()))
            
            fetchFavoritePhotos()

        } catch {

            completion(Result.failure(error))
        }
    }
    
    func deleteFavoritePhoto(_ lsFavoritePhoto: LSFavoritePhoto, completion: (Result<Void, Error>) -> Void) {

        do {

            viewContext.delete(lsFavoritePhoto)

            try viewContext.save()

            completion(Result.success(()))
            
            fetchFavoritePhotos()

        } catch {

            completion(Result.failure(error))
        }
    }
}

struct FavoritePhoto {
    
    let id: Int
    
    let title: String
    
    var photoData: Data?
    
    let createTime: Double
}

extension LSFavoritePhoto {
    
    func mapping(_ object: FavoritePhoto) {
        
        id = object.id.int64()
        
        title = object.title
        
        photoData = object.photoData
        
        createTime = object.createTime
    }
}
