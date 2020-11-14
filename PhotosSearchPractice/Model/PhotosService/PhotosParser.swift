import Foundation

struct PSSuccessParser<T: Codable>: Codable {
    
    let data: T
    
    let state: String
    
    enum CodingKeys: String, CodingKey {
        
    case data = "photos"
        
    case state = "stat"
    }
}
