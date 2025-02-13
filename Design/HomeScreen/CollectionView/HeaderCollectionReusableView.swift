import UIKit

final class SectionHeaderView: UICollectionReusableView {
    
    static var identifer = "SectionHeaderView"
    
    private let titleSectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldFont(ofSize: 18)
        label.textColor = UIColor.brownColor()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppereance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createTitle(text: String) {
        titleSectionLabel.text = text
    }
    
    private func setupAppereance() {
        self.addSubviews(titleSectionLabel)
        NSLayoutConstraint.activate([
            titleSectionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleSectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
}
