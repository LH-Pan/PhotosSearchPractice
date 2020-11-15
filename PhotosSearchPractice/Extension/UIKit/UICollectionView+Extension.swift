import UIKit

extension UICollectionView {
    
    func registerCellWithNib(identifier: String, bundle: Bundle? = nil) {
        
        let nib = UINib(nibName: identifier, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
