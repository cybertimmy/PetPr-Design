import UIKit

protocol OpenDetailScreen: AnyObject {
    func openDetailScreen(image: UIImage)
}

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
        customFirstView.openDetailsScreenDelegate = self
        self.view = customFirstView
        setupTitle()
        tapgasture()
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
    
    private func tapgasture() {
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

extension HomeViewController: OpenDetailScreen {
    func openDetailScreen(image: UIImage) {
        let customScreen = CustomPresentationViewController(image: image)
        customScreen.modalPresentationStyle = .pageSheet
        customScreen.sheetPresentationController?.prefersGrabberVisible = true
        customScreen.transitioningDelegate = self
        present(customScreen, animated: true)
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
