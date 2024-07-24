import UIKit

final class PictureView: UIView, UICollectionViewDataSource  {
    
    public var results: [Result] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let textFieldColor: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.boldFont(ofSize: 20)]
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.placeholder = "Find anything"    
        return searchBar
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 180, height: 180)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: PictureCollectionViewCell.identifer)
        collectionView.backgroundColor = UIColor.darkBGColor()
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewAndSearchBar()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionViewAndSearchBar() {
        collectionView.dataSource = self
        searchBar.delegate = self
    }

    private func constraints() {
        self.addSubviews(searchBar, collectionView)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    public func fetchPhotos(query: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&query=\(query)&client_id=xAZ1YDLBy9RSRrcDfj6kaULtG-a9gXyWAet3vzPFprg"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponce.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.collectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.identifer, for: indexPath) as! PictureCollectionViewCell
        let imageURLString = results[indexPath.row].urls.regular
        cell.configure(with: imageURLString)
        return cell
    }
}

extension PictureView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = []
            collectionView.reloadData()
            fetchPhotos(query: text)
        }
    }
}
