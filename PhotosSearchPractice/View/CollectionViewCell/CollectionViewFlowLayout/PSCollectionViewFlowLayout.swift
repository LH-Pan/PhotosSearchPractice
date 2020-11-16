import UIKit

class PSCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let inset: CGFloat = CGFloat(8).convertWithSimulatorWidth()
    
    override func prepare() {
        
        let itemWidth = (UIScreen.width - inset * 3) / 2
        
        let itemHeight = itemWidth + CGFloat(25).convertWithSimulatorHeight()
        
        minimumInteritemSpacing = inset
        
        sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
}
