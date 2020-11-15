import UIKit

struct FavoriteCellViewModel {
    
    let title: String
    
    var photoData: Data?
}

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellViewModel: FavoriteCellViewModel? {
        
        didSet {
            
            guard let cellVM = cellViewModel else { return }
            
            titleLabel.text = cellVM.title
            
            photoImageView.image = UIImage(data: cellVM.photoData ?? Data())
        }
    }
}
