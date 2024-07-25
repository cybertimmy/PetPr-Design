import UIKit

final class CustomPresentationView: UIView {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.register(CustomPresentationCollectionViewCell.self, forCellWithReuseIdentifier: CustomPresentationCollectionViewCell.identifer)
        collectionView.backgroundColor = .none
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
        setupApperiance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackground() {
        self.backgroundColor = UIColor.darkBGColor()
    }
    
    private func setupApperiance() {
 
        NSLayoutConstraint.activate([

        ])
    }
}
