import UIKit

final class LoginScreenView: UIView {
    
    private var textFieldsStackView: UIStackView!
    
    private let logoImage: UIImageView = {
        let logoImage = UIImageView(image: UIImage.imageAppartament19)
        return logoImage
    }()
    
    private let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Design"
        label.font = UIFont.boldFont(ofSize: 25)
        label.textColor = UIColor.white
        return label
    }()
    
    public let loginTextField: UITextField = {
        let textField = UITextField()
        let textFieldColor: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.boldFont(ofSize: 20)]
        textField.placeholder = "Login"
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.font = UIFont.boldFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 16
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: textFieldColor)
        textField.backgroundColor = .brownColor()
        return textField
    }()
    
    public let passwordTextField: UITextField = {
        let textField = UITextField()
        let textFieldColor: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.boldFont(ofSize: 20)]
        textField.placeholder = "Password"
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.font = UIFont.boldFont(ofSize: 20)
        textField.borderStyle = .roundedRect
//        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 16
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: textFieldColor)
        textField.backgroundColor = UIColor.brownColor()
        return textField
    }()
    
    public let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.titleLabel?.font = UIFont.boldFont(ofSize: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.brownColor()
        button.layer.cornerRadius = 10
        return button
    }()
    
    public let registrationButton: UIButton = {
            let button = UIButton()
            button.setTitle("register?", for: .normal)
            button.titleLabel?.font = UIFont.lightFont(ofSize: 15)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = .none
            return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupBgColor()
        setupApperiance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBgColor() {
        self.backgroundColor = UIColor.darkBGColor()
    }
    
    private func setupStackView() {
        textFieldsStackView = UIStackView(arrangedSubviews: [loginTextField,
                                                             passwordTextField])
        textFieldsStackView.distribution = .equalSpacing
        textFieldsStackView.spacing = 25
        textFieldsStackView.axis = .vertical
    }
    
    private func setupApperiance() {
        self.addSubviews(
            textFieldsStackView,
            logoImage,
            mainTextLabel,
            registrationButton,
            enterButton
        )
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            
            mainTextLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            mainTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            textFieldsStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 250),
            textFieldsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            textFieldsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registrationButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 15),
            registrationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            enterButton.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 150),
            enterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            enterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            enterButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
