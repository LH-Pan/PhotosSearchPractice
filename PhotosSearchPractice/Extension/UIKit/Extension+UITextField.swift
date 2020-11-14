import UIKit

extension UITextField {
    
    func setupBorderAndRadius(borderWidth: CGFloat, borderColor: UIColor = .clear, cornerRadius: CGFloat) {
        
        layer.borderWidth = borderWidth
        
        layer.borderColor = borderColor.cgColor
        
        layer.cornerRadius = cornerRadius
    }
}
