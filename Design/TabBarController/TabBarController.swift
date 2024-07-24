import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setupTabs()
        self.setupAppearance()
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabs() {
        let homeNavigationController = self.createNavigationController(image: .houseImage, controller: HomeViewController())
        let toDoNavigationController = self.createNavigationController(image: .checklistImage, controller: ToDoViewController())
        let pictureNavigationController = self.createNavigationController(image: .magnifyingglassImage, controller: PictureViewController())
        let mapScreenNavigationContoller = self.createNavigationController(image: .mapImage, controller: MapScreenViewController())

        homeNavigationController.navigationItem.largeTitleDisplayMode = .automatic
        toDoNavigationController.navigationItem.largeTitleDisplayMode = .automatic
        pictureNavigationController.navigationItem.largeTitleDisplayMode = .automatic
        mapScreenNavigationContoller.navigationItem.largeTitleDisplayMode = .automatic
    
        for navigationController in [homeNavigationController,toDoNavigationController, pictureNavigationController,mapScreenNavigationContoller] {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        self.setViewControllers([homeNavigationController,toDoNavigationController, pictureNavigationController,mapScreenNavigationContoller], animated: true)
    }
    
    private func setupAppearance() {
        self.tabBar.tintColor = UIColor.brownColor()
        UITabBar.appearance().barTintColor = UIColor.brownColor()
        self.tabBar.backgroundColor = UIColor.darkBGColor()
    }

    private func createNavigationController(image: UIImage?, controller: UIViewController) -> UINavigationController {
        let navigationContoller = UINavigationController(rootViewController: controller)
        controller.tabBarItem.image = image
        return navigationContoller
    }
}
