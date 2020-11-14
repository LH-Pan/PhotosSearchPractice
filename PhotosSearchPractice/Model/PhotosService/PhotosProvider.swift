import Foundation

typealias PhotosSearchHandler = (Result<PSSuccessParser<PhotosObject>, HTTPClientError>) -> Void

class PhotosProvider {
    
    let encoder = JSONEncoder()
    
    let decoder = JSONDecoder()
    
    func fetchPhotos(page: Int, limit: Int, text: String, completion: @escaping PhotosSearchHandler) {
        
        let encodeUrlText = text.urlEncoded()
        
        HTTPClient.shared.request(PhotosRequest.fetchPhotos(page: page, limit: limit, text: encodeUrlText)) { [weak self] result in
            
            guard let strongSelf = self else { return }
            
            switch result {
                
            case .success(let data):
                
                do {
                    
                    let photosData = try strongSelf.decoder.decode(PSSuccessParser<PhotosObject>.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        completion(Result.success(photosData))
                    }
                    
                } catch {
                    
                    completion(Result.failure(HTTPClientError.clientError))
                }
                
            case .failure(let error):
                
                guard let httpError = error as? HTTPClientError else {
                    
                    print("Unexpected Error: \(error)")
                    
                    return
                }
                
                switch httpError {
                    
                case .clientError: completion(Result.failure(HTTPClientError.clientError))
                    
                case .decodeDataFail: completion(Result.failure(HTTPClientError.decodeDataFail))
                    
                case .severError: completion(Result.failure(HTTPClientError.severError))
                    
                case .unexpectedError: completion(Result.failure(HTTPClientError.unexpectedError))
                }
            }
        }
    }
}
