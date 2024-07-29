import UIKit
import FirebaseAuth
import FirebaseFirestore

final class RegistrationScreenViewController: UIViewController {
    
    private let registrationScreenView: RegistrationScreenView
    private let resigtrarionViewModel: RegistrationViewModel
        
    init(_ viewModel: RegistrationViewModel) {
        self.registrationScreenView = RegistrationScreenView()
        self.resigtrarionViewModel = viewModel
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
            return
        }
        if password != repeatPassword {
            notificationAlert(title: "Error", message: "Eror password dont equal repeat password")
            return
        }
        resigtrarionViewModel.register(email, password) { sucess in
            if sucess {
                self.notificationAlert(title: "Registration successful", message: "You can log in")
                self.transitionToLoginScreen()
            } else {
                self.notificationAlert(title: "Error", message: "Invalid regestritaion, try again")
            }
        }
    }
        
    private func transitionToLoginScreen() {
        navigationController?.popViewController(animated: true)
    }
}

