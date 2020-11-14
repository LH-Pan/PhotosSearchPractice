import Foundation
    
extension String {
    
    static let empty = ""
    
    func urlEncoded() -> String {
        
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        return encodeUrlString ?? .empty
    }
}

