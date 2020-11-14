import Foundation
import Alamofire

enum HTTPClientError: Error {
    
    case decodeDataFail
    
    case clientError
    
    case severError
    
    case unexpectedError
}

enum HTTPMethod: String {
    
    case GET
}

enum HTTPHeaderKey: String {
    
    case contentType = "Content-Type"
}

enum HTTPHeaderValue: String {
    
    case applicationJson = "application/json"
}

protocol PSRequest {
    
    var headers: [String: String] { get }
    
    var body: Data? { get }
    
    var method: String { get }
    
    var urlString: String { get }
}

extension PSRequest {
    
    func makeRequest() -> URLRequest {
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        request.httpBody = body
        
        request.httpMethod = method
        
        return request
    }
}

class HTTPClient {
    
    static let shared = HTTPClient()
    
    private init() {}
    
    func request(_ psRequest: PSRequest, completion: @escaping (Result<Data>) -> Void) {
        
        Alamofire.request(psRequest.makeRequest()).responseJSON { response in
            
            guard response.error == nil else {

                return completion(Result.failure(response.error!))
            }

            guard let httpResponse = response.response else { return }

            let statusCode = httpResponse.statusCode

            switch statusCode {
                
            case 200..<300:
                
                completion(Result.success(response.data!))
                
            case 400..<500:
                
                completion(Result.failure(HTTPClientError.clientError))
                
            case 500..<600:
                
                completion(Result.failure(HTTPClientError.severError))
                
            default: return
                
                completion(Result.failure(HTTPClientError.unexpectedError))
            }
        }
    }
}
