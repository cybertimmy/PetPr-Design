import UIKit

final class CustomPresentationView: UIView {
    
    private var textFieldsStackView: UIStackView!
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculation of the area of ​​a square room"
        label.font = UIFont.boldFont(ofSize: 10)
        label.textColor = UIColor.white
        return label
    }()
    
    public let lengthTextField: UITextField = {
        let textField = UITextField()
        let textFieldColor: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.lightFont(ofSize: 10)]
        textField.placeholder = "Lendth"
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.font = UIFont.boldFont(ofSize: 15)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 16
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: textFieldColor)
        textField.backgroundColor = UIColor.brownColor()
        return textField
    }()
    
    public let widthTextField: UITextField = {
        let textField = UITextField()
        let textFieldColor: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.lightFont(ofSize: 10)]
        textField.placeholder = "Width"
        textField.textColor = UIColor.white
        textField.keyboardType = .numberPad
        textField.tintColor = UIColor.white
        textField.font = UIFont.boldFont(ofSize: 15)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 16
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: textFieldColor)
        textField.backgroundColor = UIColor.brownColor()
        return textField
    }()
    
    public let resultTextField: UITextField = {
        let textField = UITextField()
        let textFieldColor: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.lightFont(ofSize: 10)]
        textField.placeholder = "Result"
        textField.isUserInteractionEnabled = false
        textField.textColor = UIColor.white
        textField.keyboardType = .numberPad
        textField.tintColor = UIColor.white
        textField.font = UIFont.boldFont(ofSize: 15)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 16
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: textFieldColor)
        textField.backgroundColor = UIColor.brownColor()
        return textField
    }()
    
    public let resultButton: UIButton = {
            let button = UIButton()
            button.setTitle("Result", for: .normal)
            button.titleLabel?.font = UIFont.boldFont(ofSize: 20)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.brownColor()
            button.layer.cornerRadius = 10
            return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupBackground()
        setupApperiance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackground() {
        self.backgroundColor = UIColor.darkBGColor()
    }
    
    private func setupStackView() {
        textFieldsStackView = UIStackView(arrangedSubviews: [lengthTextField,
                                                             widthTextField,
                                                             resultTextField])
        textFieldsStackView.distribution = .equalSpacing
        textFieldsStackView.spacing = 10
        textFieldsStackView.axis = .vertical
    }
    
    private func setupApperiance() {
        self.addSubviews(textFieldsStackView,resultButton,mainTitleLabel)
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 360),
            mainTitleLabel.centerXAnchor.constraint(equalTo:self.centerXAnchor),
            
            textFieldsStackView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 50),
            textFieldsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -55),
            textFieldsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 55),
            
            resultButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            resultButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -55),
            resultButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 55)
        ])
    }
}
