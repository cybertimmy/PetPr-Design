import UIKit


final class RegistrationScreenView: UIView {
    
    private var textFieldsStackView: UIStackView!
    
    public let loginTextField: UITextField = {
        let textField = UITextField()
        let textFieldColor: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.boldFont(ofSize: 20)]
        textField.placeholder = "Email"
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.font = UIFont.boldFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 16
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: textFieldColor)
        textField.backgroundColor = UIColor.brownColor()
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
        textField.layer.cornerRadius = 16
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: textFieldColor)
        textField.backgroundColor = UIColor.brownColor()
        return textField
    }()
    
    public let repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        let textFieldColor: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.boldFont(ofSize: 20)]
        textField.placeholder = "Repeat password"
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.font = UIFont.boldFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 16
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: textFieldColor)
        textField.backgroundColor = UIColor.brownColor()
        return textField
    }()
    
    public let registerButton: UIButton = {
            let button = UIButton()
            button.setTitle("Enter", for: .normal)
            button.titleLabel?.font = UIFont.boldFont(ofSize: 20)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.brownColor()
            button.layer.cornerRadius = 10
            return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupApperiance()
        setupBgColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        textFieldsStackView = UIStackView(arrangedSubviews: [loginTextField,
                                                             passwordTextField,
                                                             repeatPasswordTextField])
        textFieldsStackView.distribution = .equalSpacing
        textFieldsStackView.spacing = 30
        textFieldsStackView.axis = .vertical
    }
    
    private func setupBgColor() {
        self.backgroundColor = UIColor.darkBGColor()
    }
    
    private func setupApperiance() {
        self.addSubviews(textFieldsStackView,registerButton)
        NSLayoutConstraint.activate([
            textFieldsStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 160),
            textFieldsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            textFieldsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
        
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 150),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
