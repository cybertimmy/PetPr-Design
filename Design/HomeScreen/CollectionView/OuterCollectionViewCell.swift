import UIKit

protocol OuterCollectionViewCellDelegate: AnyObject {
    func didSelectImage(image: UIImage)
}

final class OuterCollectionViewCell: UICollectionViewCell {

    static var identifer = "OuterCollectionViewCell"
    private var innerData: [UIImage] = []
    weak var delegate: OuterCollectionViewCellDelegate?
 
    private var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomHomeCollectionViewCell.self, forCellWithReuseIdentifier: CustomHomeCollectionViewCell.identifer)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .darkBGColor()
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionView)
        setupCollectionView()
        setupAppereance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setInnerData(data: [UIImage]) {
        self.innerData = data
        
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupAppereance() {
        self.addSubviews(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 115),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -115),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension OuterCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        innerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomHomeCollectionViewCell.identifer, for: indexPath) as! CustomHomeCollectionViewCell
        cell.imageView.image = innerData[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = innerData[indexPath.item]
        delegate?.didSelectImage(image: selectedImage)
    }
}
