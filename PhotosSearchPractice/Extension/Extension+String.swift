import Foundation
    
extension String {
    
    func urlEncoded() -> String {
        
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        return encodeUrlString ?? ""
    }
}

