import UIKit

struct ResultCellViewModel {
    
    let imageUrlText: String
    
    let titleText: String
}

class ResultCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellViewModel: ResultCellViewModel? {
        
        didSet {
            
            guard let cellVM = cellViewModel else { return }
            
            titleLabel.text = cellVM.titleText
            
            photoImageView.loadImage(cellVM.imageUrlText)
        }
    }
}
