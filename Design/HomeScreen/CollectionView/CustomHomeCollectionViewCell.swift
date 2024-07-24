import UIKit

final class CustomHomeCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "CustomHomeCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 14, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    public func createNameLabel(label: String) {
        nameLabel.text = label
    }
    
    private func constraints() {
        contentView.addSubviews(imageView, nameLabel)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
        ])
    }
}



