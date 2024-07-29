import UIKit

final class HomeView: UIView {

    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.register(OuterCollectionViewCell.self, forCellWithReuseIdentifier: OuterCollectionViewCell.identifer)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifer)
        return collectionView
    }()
    
    public var userImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pixel"))
        imageView.layer.masksToBounds = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(red: 236/255, green: 177/255, blue: 118/255, alpha: 1.0)
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, User"
        label.font = UIFont.boldFont(ofSize: 30)
        label.textColor = UIColor.brownColor()
        return label
    }()
    
    private let arrayImage1: [UIImage] =  [.imageAppartament1!, .imageAppartament2!, .imageAppartament3!, .imageAppartament4!, .imageAppartament5!, .imageAppartament6!]
    private let arrayImage2: [UIImage] =  [.imageAppartament7!, .imageAppartament8!, .imageAppartament9!, .imageAppartament10!, .imageAppartament11!, .imageAppartament12!]
    private let arrayImage3: [UIImage] =     [.imageAppartament13!, .imageAppartament14!, .imageAppartament15!, .imageAppartament16!, .imageAppartament17!, .imageAppartament18!]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupBGColor()
        setupApperiance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupBGColor() {
        self.backgroundColor = UIColor.darkBGColor()
    }
    
    private func setupApperiance() {
        self.addSubviews(userImage,userNameLabel,collectionView)
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            userImage.widthAnchor.constraint(equalToConstant: 60),
            userImage.heightAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
            userNameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 15),
            
            collectionView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OuterCollectionViewCell.identifer, for: indexPath) as! OuterCollectionViewCell
        switch indexPath.section {
        case 0: cell.setInnerData(data: arrayImage1)
        case 1: cell.setInnerData(data: arrayImage2)
        case 2: cell.setInnerData(data: arrayImage3)
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 600, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifer, for: indexPath) as! SectionHeaderView
            switch indexPath.section {
            case 0: header.createTitle(text: "Design appartament")
            case 1: header.createTitle(text: "Design bathroom")
            case 2: header.createTitle(text: "Design children`s room")
            default:
                break
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}


