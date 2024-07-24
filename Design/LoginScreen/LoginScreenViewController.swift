import UIKit
import FirebaseAuth

final class LoginScreenViewContoller: UIViewController {
    
    private let loginScreenView: LoginScreenView
    
    init() {
        self.loginScreenView = LoginScreenView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = loginScreenView
        pressedForRegistrationAccount()
        loginToAccount()
    }

    override func viewDidLoad() {
         super.viewDidLoad()
     }
        
    private func transitionToTabBar() {
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true, completion: nil)
    }
    
    private func loginToAccount() {
        loginScreenView.enterButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func pressedForRegistrationAccount() {
        loginScreenView.registrationButton.addTarget(self, action: #selector(didPressedForRegistrationAccount), for: .touchUpInside)
    }
 }

extension LoginScreenViewContoller {
    
    @objc private func loginButtonTapped() {
        guard let email = loginScreenView.loginTextField.text, !email.isEmpty,
              let password = loginScreenView.passwordTextField.text, !password.isEmpty else {
            print("Please fill in all fields")
            notificationAlert(title: "Error fields", message: "Fields cannot be empty")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                print("Error logging in: \(error.localizedDescription)")
                print("Error details: \(error.userInfo)")
                self.notificationAlert(title: "Error", message: "Invalid email or password")
                return
            }
            print("User logged in successfully")
            self.transitionToTabBar()
            self.notificationAlert(title: "Succesful", message: "Registration completed successfully. Now you can enter")
        }
    }
    
    @objc private func didPressedForRegistrationAccount() {
        navigationController?.pushViewController(RegistrationScreenViewController(), animated: true)
    }
}
