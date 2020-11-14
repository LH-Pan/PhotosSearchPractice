import Foundation

struct URLConstant {
    
    static let FlickrPhotosSearch = "https://www.flickr.com/services/rest/?method=flickr.photos.search"
}

struct FlickrAPI {
    
    static let key = "736c0c512e7dd051c93cea844bdab8bf"
}

enum PhotosRequest: PSRequest {
    
    case fetchPhotos(page: Int, limit: Int, text: String)
    
    var headers: [String : String] {
        
        switch self {
            
        case .fetchPhotos:
            
            return [HTTPHeaderKey.contentType.rawValue: HTTPHeaderValue.applicationJson.rawValue]
        }
    }
    
    var body: Data? {
        
        switch self {
            
        case .fetchPhotos:
            
            return nil
        }
    }
    
    var method: String {
        
        switch self {
            
        case .fetchPhotos:
            
            return HTTPMethod.GET.rawValue
        }
    }
    
    var urlString: String {
        
        switch self {
            
        case .fetchPhotos(let page, let limit, let text):
            
            return  "\(URLConstant.FlickrPhotosSearch)&api_key=\(FlickrAPI.key)&text=\(text)&per_page=\(limit)&page=\(page)&format=json&nojsoncallback=1"
        }
    }
}
