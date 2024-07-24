import UIKit

final class PictureViewController: UIViewController {
    
    private let pictureView = PictureView()
    private let model = PictureModel(service: APIService())
    
    override func loadView() {
        super.loadView()
        self.view = pictureView
        setupTitleAndBG()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTitleAndBG() {
        navigationItem.title = "Find design"
        view.backgroundColor = UIColor.darkBGColor()
    }
}
