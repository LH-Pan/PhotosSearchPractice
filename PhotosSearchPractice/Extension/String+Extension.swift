import Foundation
    
extension String {
    
    static let empty = ""
    
    static let whiteSpace = " "
    
    func urlEncoded() -> String {
        
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        return encodeUrlString ?? .empty
    }
}
