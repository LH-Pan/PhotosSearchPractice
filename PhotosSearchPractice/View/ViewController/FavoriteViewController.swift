import UIKit
import SnapKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Private Constant / Variable Declare
    private let viewModel: FavoriteViewModel
    
    let favoriteCollectionView: UICollectionView =
        UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Initialize Method
    init(viewModel: FavoriteViewModel = FavoriteViewModel()) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        
        setupConstraints()
        
        setupSubviews()
        
        bindWithVM()
    }
    
    // MARK: - Private Method
    private func bindWithVM() {
        
        viewModel.reloadDataClosure = { [weak self] in
            
            DispatchQueue.main.async {
            
                self?.favoriteCollectionView.reloadData()
            }
        }
        
        viewModel.initViewModel()
    }
    
    private func addSubviews() {
        
        view.addSubview(favoriteCollectionView)
    }
    
    private func setupConstraints() {
        
        favoriteCollectionView.snp.makeConstraints { make in
            
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }
    
    private func setupSubviews() {
        
        navigationController?.navigationBar.topItem?.title = "我的最愛"
        
        view.backgroundColor = .white
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        favoriteCollectionView.dataSource = self
        
        favoriteCollectionView.backgroundColor = .white
        
        favoriteCollectionView.registerCellWithNib(identifier: FavoriteCollectionViewCell.id)
        
        setupCollectionViewLayout()
    }
    
    private func setupCollectionViewLayout() {
        
        let collectionViewLayout = favoriteCollectionView.collectionViewLayout
        
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let inset: CGFloat = CGFloat(8).convertWithSimulatorWidth()
        
        let itemWidth = (view.bounds.width - inset * 3) / 2
        
        let itemHeight = itemWidth + CGFloat(25).convertWithSimulatorHeight()
        
        layout.minimumInteritemSpacing = inset
        
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
}

// MARK: - 實作 UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.id, for: indexPath)
        
        guard let favoriteCell = cell as? FavoriteCollectionViewCell else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath.item)
        
        favoriteCell.cellViewModel = cellViewModel
        
        return favoriteCell
    }
}
