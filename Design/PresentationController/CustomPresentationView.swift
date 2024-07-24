import UIKit

final class CustomPresentationView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "32%"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.red
        return label
    }()
        
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.register(CustomHomeCollectionViewCell.self, forCellWithReuseIdentifier: CustomHomeCollectionViewCell.identifer)
        collectionView.backgroundColor = .red
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    private func setupApperiance() {
        self.addSubviews(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35)
        ])
    }
}

//MARK: - Create Layout
extension CustomPresentationView {
    
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
                                     itemHeight: .absolute(500),
                                     interItemSpacing: 10,
                                     groupWidth: .fractionalWidth(1/2),
                                     groupHeight: .absolute(300),
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
extension CustomPresentationView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomHomeCollectionViewCell.identifer, for: indexPath) as? CustomHomeCollectionViewCell else {
            fatalError("Error")
        }
       
        cell.backgroundColor = .red
        return cell
    }
}
