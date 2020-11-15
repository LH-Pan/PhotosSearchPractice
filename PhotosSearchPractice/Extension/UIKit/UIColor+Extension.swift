import UIKit

private enum PSColor: String {
    
    case skyBlue = "#287CF6"
    
    case placeHolderGray = "#BDBDBD"
    
    case navigationGray = "#F5F5F5"
}

// Custom Color
extension UIColor {
    
    static let skyBlue = PSColor(.skyBlue)
    
    static let placeHolderGray = PSColor(.placeHolderGray)
    
    static let navigationGray = PSColor(.navigationGray)
}

extension UIColor {
    
    // Hex String -> UIColor
    static func hexStringToUIColor(hex: String) -> UIColor {

        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    private static func PSColor(_ hexString: PSColor) -> UIColor {
        
        return UIColor.hexStringToUIColor(hex: hexString.rawValue)
    }
}
