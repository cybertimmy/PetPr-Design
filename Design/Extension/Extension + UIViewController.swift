import UIKit

extension UIViewController {
    public func notificationAlert(title: String, message: String) {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default)
        alertContoller.addAction(alertOk)
        present(alertContoller, animated: true)
    }
    public func addAddressAlert(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        let actionAddAddress = UIAlertAction(title: "Add", style: .default) { text in
            let textFieldText = alertController.textFields?.first
            guard let text = textFieldText?.text else {return}
            completionHandler(text)
        }
        let actionCancel = UIAlertAction(title: "Cancel" , style: .default)
        alertController.addAction(actionAddAddress)
        alertController.addAction(actionCancel)
        present(alertController, animated: true)
    }
}
