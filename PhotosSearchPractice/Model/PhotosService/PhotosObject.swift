import Foundation

struct PhotosObject: Codable {
    
    let page: Int
    
    let totalPages: Int
    
    let limit: Int
    
    let amountOfPhotos: String
    
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        
    case page
    case totalPages = "pages"
    case limit = "perpage"
    case amountOfPhotos = "total"
    case photos = "photo"
    }
}

struct Photo: Codable {
    
    let serverID: String
    
    let id: String
    
    let owner: String
    
    let secret: String
    
    let farm: Int
    
    let title: String
    
    let isPublic: Int
    
    let isFriend: Int
    
    let isFamily: Int
    
    var photoUrlString: String {
        
        "https://live.staticflickr.com/\(serverID)/\(id)_\(secret)_\(PhotoFormat.thumbnail_150.rawValue).jpg"
    }
    
    enum CodingKeys: String, CodingKey {
        
    case id, owner, secret, farm, title
    case serverID = "server"
    case isPublic = "ispublic"
    case isFriend = "isfriend"
    case isFamily = "isfamily"
    }
}

enum PhotoFormat: String {
    
    case thumbnail_75 = "s"
    
    case thumbnail_100 = "t"
    
    case thumbnail_150 = "q"
    
    case small_240 = "m"
    
    case small_320 = "n"
    
    case small_400 = "w"
    
    case medium_500 = ""
    
    case medium_640 = "z"
    
    case medium_800 = "c"
    
    case large_1024 = "b"
}
