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
        setupApperiance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
