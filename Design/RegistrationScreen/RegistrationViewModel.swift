import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewModel {
    func register(_ login: String, _ password: String, completion: @escaping(Bool)->()) {
        Auth.auth().createUser(withEmail: login, password: password) { [weak self] authResult, error in
            guard self != nil else {return}
            if error != nil {
                    return
            }
            self?.saveUserToDataBase(email: login, password: password)
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
            if error != nil {
                fatalError("Failed to save user")
            }
        }
    }
}
