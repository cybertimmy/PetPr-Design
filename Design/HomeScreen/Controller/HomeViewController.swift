import UIKit

final class HomeViewController: UIViewController {
    
    private var isHighlighted = false
    private let customFirstView: HomeView

    init() {
        self.customFirstView = HomeView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = customFirstView
        customFirstView.delegate = self
        setupTitle()
        tapGesture()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTitle() {
        navigationItem.title = "Home"
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        customFirstView.userImage.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController {
    
    private func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentPhotoLibrary))
        customFirstView.userImage.isUserInteractionEnabled = true
        customFirstView.userImage.addGestureRecognizer(tap)
    }
    
    @objc private func presentPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension HomeViewController: OuterCollectionViewCellDelegate {
    func didSelectImage(image: UIImage) {
        let customScreen = CustomPresentationViewController(image: image)
        customScreen.modalPresentationStyle = .pageSheet
        customScreen.sheetPresentationController?.prefersGrabberVisible = true
        customScreen.transitioningDelegate = self
        present(customScreen, animated: true)
    }
}
