import UIKit

final class HomeView: UIView {
    
    var openDetailsScreenDelegate: OpenDetailScreen?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.register(CustomHomeCollectionViewCell.self, forCellWithReuseIdentifier: CustomHomeCollectionViewCell.identifer)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: HeaderCollectionReusableView.self.description(), withReuseIdentifier: HeaderCollectionReusableView.identifer)
        collectionView.backgroundColor = .none
        collectionView.layer.cornerRadius = 8
        collectionView.layer.shadowOffset = CGSize(width: -4, height: 4)
        collectionView.layer.shadowOpacity = 0.3
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
        
    private let arrayImage: [[UIImage]] = [
        [UIImage.imageAppartament1!, UIImage.imageAppartament2!, UIImage.imageAppartament3!, UIImage.imageAppartament4!, UIImage.imageAppartament5!, UIImage.imageAppartament6!],
        
        [UIImage.imageAppartament7!, UIImage.imageAppartament8!, UIImage.imageAppartament9!, UIImage.imageAppartament10!, UIImage.imageAppartament11!, UIImage.imageAppartament12!],
        
        [UIImage.imageAppartament13!, UIImage.imageAppartament14!, UIImage.imageAppartament15!, UIImage.imageAppartament16!, UIImage.imageAppartament17!, UIImage.imageAppartament18!]
    ]
    
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
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
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

//MARK: - Create Layout
extension HomeView {
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            index, env in
            return self?.getSectionFor(index: index)
        }
        return layout
    }
    
    private func getSectionFor(index: Int) -> NSCollectionLayoutSection {
        switch index {
        case 0: return createSection(itemWidth: .fractionalWidth(1),
                                     itemHeight: .absolute(200),
                                     interItemSpacing: 10,
                                     groupWidth: .fractionalWidth(1 / 2),
                                     groupHeight: .absolute(100),
                                     interGroupSpacing: 10,
                                     headerHight: .absolute(50),
                                     sectionInsets: .init(top: 10, leading: 10, bottom: 120, trailing: 10),
                                     scrollBehavior: .continuous)
        case 1: return createSection(itemWidth: .fractionalWidth(1),
                                     itemHeight: .absolute(200),
                                     interItemSpacing: 10,
                                     groupWidth: .fractionalWidth(1 / 2),
                                     groupHeight: .absolute(100),
                                     interGroupSpacing: 10,
                                     headerHight: .absolute(50),
                                     sectionInsets: .init(top: 10, leading: 10, bottom: 120, trailing: 10),
                                     scrollBehavior: .continuous)
        case 2: return createSection(itemWidth: .fractionalWidth(1),
                                     itemHeight: .absolute(200),
                                     interItemSpacing: 10,
                                     groupWidth: .fractionalWidth(1 / 2),
                                     groupHeight: .absolute(100),
                                     interGroupSpacing: 10,
                                     headerHight: .absolute(50),
                                     sectionInsets: .init(top: 10, leading: 10, bottom: 120, trailing: 10),
                                     scrollBehavior: .continuous)
        default: break
        }
        return emptySection()
    }
    
    private func createSection(itemWidth: NSCollectionLayoutDimension,
                               itemHeight: NSCollectionLayoutDimension,
                               interItemSpacing: Double = 0,
                               groupWidth: NSCollectionLayoutDimension,
                               groupHeight:NSCollectionLayoutDimension,
                               interGroupSpacing: Double = 0,
                               headerHight: NSCollectionLayoutDimension? = nil, 
                               sectionInsets: NSDirectionalEdgeInsets = .zero, 
                               scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth,
                                              heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                               heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.interItemSpacing = .fixed(interItemSpacing)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = scrollBehavior
        section.interGroupSpacing = interGroupSpacing
        section.contentInsets = sectionInsets
        section.boundarySupplementaryItems = []
        
        if let headerHight = headerHight {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: headerHight)
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: HeaderCollectionReusableView.description(), alignment: .top)
            section.boundarySupplementaryItems.append(header)
        }
        return section
    }
    
    private func emptySection(height: CGFloat = 0) -> NSCollectionLayoutSection {
        return createSection(itemWidth: .fractionalWidth(1),
                             itemHeight: .absolute(height),
                             groupWidth: .fractionalWidth(1),
                             groupHeight: .absolute(1))
    }
}

//MARK: - DataSource, Delegate - CollectionView
extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        arrayImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayImage[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomHomeCollectionViewCell.identifer, for: indexPath) as? CustomHomeCollectionViewCell else {
            fatalError("Error")
        }
        let images = arrayImage[indexPath.section][indexPath.item]
        cell.configure(with: images)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == HeaderCollectionReusableView.self.description() {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifer, for: indexPath) as! HeaderCollectionReusableView
            if indexPath.section == 0 {
                cell.titleAndSubtitle(text:"Design appartament")
            } else if indexPath.section == 1 {
                cell.titleAndSubtitle(text: "Design bathroom")
            } else if indexPath.section == 2 {
                cell.titleAndSubtitle(text: "Design children`s room ")
            }
            return cell
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = self.arrayImage[indexPath.section][indexPath.item]
        openDetailsScreenDelegate?.openDetailScreen(image: image)
    }
}
