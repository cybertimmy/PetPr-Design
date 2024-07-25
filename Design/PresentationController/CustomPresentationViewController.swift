import UIKit

final class CustomPresentationViewController: UIViewController {
    
    private let customPresentationView: CustomPresentationView
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
        self.customPresentationView = CustomPresentationView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = customPresentationView
        actionCalculateMeters()
        setupApperiance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    private func actionCalculateMeters() {
        customPresentationView.resultButton.addTarget(self, action: #selector(calculateMeters), for: .touchUpInside)
    }
    
    private func setupApperiance() {
        let imageView = UIImageView(image: self.image)
        imageView.contentMode = .scaleToFill
        view.addSubviews(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

extension CustomPresentationViewController {
    @objc private func calculateMeters() {
        guard let text1 = customPresentationView.lengthTextField.text, let text2 = customPresentationView.widthTextField.text else {
            customPresentationView.resultTextField.text = "Error! Feel all fields"
            return
        }
        guard let num1 = Double(text1), let num2 = Double(text2) else {
            customPresentationView.resultTextField.text = "Error convert"
            return
        }
        let result = num1 * num2
        customPresentationView.resultTextField.text = "\(result)"
        customPresentationView.lengthTextField.text = ""
        customPresentationView.widthTextField.text = ""
    }
}
