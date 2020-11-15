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
        
        viewModel.reloadDateClosure = { [weak self] in
            
            DispatchQueue.main.async {
                
                self?.resultCollectionView.reloadData()
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
        
        resultCollectionView.dataSource = self
        
        resultCollectionView.registerCellWithNib(identifier: ResultCollectionViewCell.id)
        
        resultCollectionView.backgroundColor = .white
        
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
extension ResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.id, for: indexPath)
        
        guard let resultCell = cell as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath.item)

        resultCell.cellViewModel = cellViewModel
        
        return resultCell
    }
}
