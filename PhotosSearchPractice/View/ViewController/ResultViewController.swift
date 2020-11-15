import UIKit
import SnapKit

class ResultViewController: UIViewController {
    
    // MARK: - Private Constant / Variable Declare
    private let viewModel: ResultViewModel
    
    let resultCollectionView: UICollectionView =
        UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Initialize Method
    init(viewModel: ResultViewModel) {
        
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
                
                self?.resultCollectionView.reloadData()
                
                self?.resultCollectionView.endHeaderRefreshing()
            }
        }
        
        viewModel.insertCellsClosure = { [weak self] newCells, oldCells in
            
            DispatchQueue.main.async {
                
                var indexPaths: [IndexPath] = []
                
                for index in oldCells.count..<newCells.count {
                    
                    indexPaths.append(IndexPath(row: index, section: 0))
                }
                
                self?.resultCollectionView.insertItems(at: indexPaths)
            }
        }
        
        viewModel.initViewModel()
    }
    
    private func addSubviews() {
        
        view.addSubview(resultCollectionView)
    }
    
    private func setupConstraints() {
        
        resultCollectionView.snp.makeConstraints { make in
            
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }
    
    private func setupSubviews() {
        
        title = "搜尋結果 \(viewModel.searchItemText)"
        
        view.backgroundColor = .white
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        resultCollectionView.delegate = self
        
        resultCollectionView.dataSource = self
        
        resultCollectionView.backgroundColor = .white
        
        resultCollectionView.registerCellWithNib(identifier: ResultCollectionViewCell.id)
        
        resultCollectionView.addRefreshHeader { [weak self] in
            
            self?.viewModel.refreshFetchPhotos()
        }
        
        setupCollectionViewLayout()
    }
    
    private func setupCollectionViewLayout() {
        
        let collectionViewLayout = resultCollectionView.collectionViewLayout
        
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
extension ResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.id, for: indexPath)
        
        guard let resultCell = cell as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath.item)

        resultCell.cellViewModel = cellViewModel
        
        resultCell.delegate = self
        
        return resultCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut, animations: {
            
            cell.alpha = 1
        })
        
        animator.startAnimation()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > (scrollView.contentSize.height - UIScreen.main.bounds.height) {
            
            viewModel.fetchPhotos()
        }
    }
}

// MARK: - 實作 AddFavoriteDelegate
extension ResultViewController: AddFavoriteDelegate {
    
    func didPressed(_ cell: ResultCollectionViewCell, didGet imageData: Data?) {
        
        guard let indexPath = resultCollectionView.indexPath(for: cell) else { return }
        
        viewModel.didSelectedFavorite(at: indexPath.item, imageData: imageData)
    }
}
