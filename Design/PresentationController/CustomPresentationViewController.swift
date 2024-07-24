import UIKit

final class CustomPresentationViewController: UIViewController {
    
    private let image: UIImage
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.register(CustomPresentationCollectionViewCell.self, forCellWithReuseIdentifier: CustomPresentationCollectionViewCell.identifer)
        collectionView.backgroundColor = .none
        return collectionView
    }()

    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupCollectionView()
        setupBackground()
        setupApperiance()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.darkBGColor()
    }
    
    private func setupApperiance() {
        let imageView = UIImageView(image: self.image)
        imageView.contentMode = .scaleToFill
        view.addSubviews(imageView, collectionView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            collectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - Create Layout
extension CustomPresentationViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            index, env in
            return self?.getSectionFor(index: index)
        }
        return layout
    }
    
    private func getSectionFor(index: Int) -> NSCollectionLayoutSection {
        switch index {
        case 0: return createSection(itemWidth: .fractionalWidth(1 / 2),
                                     itemHeight: .absolute(225),
                                     interItemSpacing: 10,
                                     groupWidth: .fractionalWidth(1),
                                     groupHeight: .absolute(100),
                                     interGroupSpacing: 10,
                                     headerHight: .absolute(50),
                                     sectionInsets: .init(top: 10, leading: 10, bottom: 120, trailing: 10),
                                     scrollBehavior: .none)
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
extension CustomPresentationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomPresentationCollectionViewCell.identifer, for: indexPath) as? CustomPresentationCollectionViewCell else {
            fatalError("Error")
        }
        switch indexPath.item {
        case 0: cell.setupTitle(with: "42%")
                cell.setupSubtitle(with: "Увлажнитель воздуха")
        case 1: cell.setupTitle(with: "89%")
                cell.setupSubtitle(with: "Очиститель воздуха")
        default:
            break
        }
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 16
        cell.backgroundColor = UIColor(red: 42/255, green: 39/255, blue: 38/255, alpha: 100)
        return cell
    }
}
