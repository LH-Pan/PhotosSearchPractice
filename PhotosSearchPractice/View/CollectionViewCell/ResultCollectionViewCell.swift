import UIKit

struct ResultCellViewModel {
    
    let imageUrlText: String
    
    let titleText: String
    
    var isFavorite: Bool = false
}

protocol AddFavoriteDelegate: AnyObject {
    
    func didPressed(_ cell: ResultCollectionViewCell)
}

class ResultCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: AddFavoriteDelegate?
    
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
        
        delegate?.didPressed(self)
    }
}
