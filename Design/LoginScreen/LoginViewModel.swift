import Foundation
import FirebaseAuth

final class LoginViewModel {
    
    func login(_ login: String, _ password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
            if (error as NSError?) != nil {
                completion(false)
            }
            completion(true)
        }
    }
}
