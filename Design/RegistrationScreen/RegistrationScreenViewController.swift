import UIKit
import FirebaseAuth
import FirebaseFirestore

final class RegistrationScreenViewController: UIViewController {
    
    private let registrationScreenView: RegistrationScreenView
        
    init() {
        self.registrationScreenView = RegistrationScreenView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = registrationScreenView
        entryButtonAction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func entryButtonAction() {
        registrationScreenView.registerButton.addTarget(self, action: #selector(entryButtonTapped), for: .touchUpInside)
    }
}

extension RegistrationScreenViewController {
    
    @objc private func entryButtonTapped() {
        guard let email = registrationScreenView.loginTextField.text, !email.isEmpty,
              let password = registrationScreenView.passwordTextField.text, !password.isEmpty,
              let repeatPassword = registrationScreenView.repeatPasswordTextField.text, !repeatPassword.isEmpty else {
            notificationAlert(title: "Error", message: "Email and password must not be empty")
            print("Email and password must not be empty")
            return
        }
        if password != repeatPassword {
            print("Eror password dont equal repeat password")
            notificationAlert(title: "Error", message: "Eror password dont equal repeat password")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else {return}
            if let error = error {
                    print("Error registering user:\(error.localizedDescription)")
                    return
            }
            self?.saveUserToDataBase(email: email, password: password)
            self?.transitionToLoginScreen()
            self?.notificationAlert(title: "Registration successful", message: "You can log in")
        }
    }
    
    private func saveUserToDataBase(email: String, password:String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let userData = ["email": email,
                        "password": password]
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User data saved sucessful")
            }
        }
    }
    
    private func transitionToLoginScreen() {
        navigationController?.popViewController(animated: true)
    }
}

