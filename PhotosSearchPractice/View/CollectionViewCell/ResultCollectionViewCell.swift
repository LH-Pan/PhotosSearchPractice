import UIKit

struct ResultCellViewModel {
    
    let id: Int
    
    let imageUrlText: String
    
    let titleText: String
    
    var isFavorite: Bool = false
}

protocol ResultCollectionViewCellDelegate: AnyObject {
    
    func resultCollectionViewCell(_ cell: ResultCollectionViewCell, didGet image: UIImage?)
}

class ResultCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: ResultCollectionViewCellDelegate?
    
    var cellViewModel: ResultCellViewModel? {
        
        didSet {
            
            guard let cellVM = cellViewModel else { return }
            
            titleLabel.text = cellVM.titleText
            
            photoImageView.loadImage(cellVM.imageUrlText)
            
            favoriteButton.isSelected = cellVM.isFavorite
        }
    }
    
    @IBAction func clickFavoriteButton(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        
        delegate?.resultCollectionViewCell(self, didGet: photoImageView.image)
    }
}
