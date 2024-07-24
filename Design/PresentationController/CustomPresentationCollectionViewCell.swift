import UIKit

final class CustomPresentationCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "CustomPresentationCollectionViewCell"
    
    private let toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = false
        toggleSwitch.onTintColor = UIColor.brownColor()
        return toggleSwitch
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldFont(ofSize: 35)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.subtitleColor()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.lightFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppereance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupTitle(with text: String) {
        titleLabel.text = text
    }
    
    public func setupSubtitle(with text: String) {
        subtitleLabel.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    private func setupAppereance() {
        self.addSubviews(titleLabel, subtitleLabel, toggleSwitch)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 110),
            
            toggleSwitch.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 35),
            toggleSwitch.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        ])
    }
}


