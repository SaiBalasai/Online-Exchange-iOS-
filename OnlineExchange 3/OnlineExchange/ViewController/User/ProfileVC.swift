
import UIKit

class ProfileVC: BaseViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fullname: UITextField!
    var products: [ProductModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.text = UserDefaultsManager.shared.getEmail()
        fullname.text = UserDefaultsManager.shared.getFullname()
        fullname.isUserInteractionEnabled = true
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        showLogoutAlert()
    }
    
    @IBAction func update(_ sender: Any) {
        print("Update button tapped")
                guard let updatedFullName = fullname.text, !updatedFullName.isEmpty else {
                    print("Full name cannot be empty.")
                    return
                }

                // Show alert before updating
                let alertBefore = UIAlertController(title: "Update Full Name", message: "Are you sure you want to update your full name to '\(updatedFullName)'?", preferredStyle: .alert)

                let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
                    if let userId = UserDefaults.standard.string(forKey: "documentId") {
                        FireStoreManager.shared.updateUserFullName(userId: userId, newFullName: updatedFullName) { success in
                            if success {
                                // Disable the fullname text field after successful update
                                self.fullname.isUserInteractionEnabled = false

                                // Show success alert after updating
                                let alertAfter = UIAlertController(title: "Success", message: "Your full name has been updated successfully.", preferredStyle: .alert)
                                alertAfter.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alertAfter, animated: true, completion: nil)
                            } else {
                                // Show error alert if update failed
                                let alertError = UIAlertController(title: "Error", message: "Failed to update your full name. Please try again.", preferredStyle: .alert)
                                alertError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alertError, animated: true, completion: nil)
                            }
                        }
                    } else {
                        print("User ID not found.")
                    }
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                alertBefore.addAction(confirmAction)
                alertBefore.addAction(cancelAction)

                // Set the color of the "Yes" button to red
                alertBefore.setActionColor(actionTitle: "Yes", color: .red)

                present(alertBefore, animated: true, completion: nil)
            }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showLogoutAlert() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            self.handleLogout()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func handleLogout() {
        UserDefaultsManager.shared.clearData()
        SceneDelegate.shared!.openHomeOrLogin()
    }

}
extension UIAlertController {
    func setActionColor(actionTitle: String, color: UIColor) {
        if let actions = self.actions as? [UIAlertAction] {
            for action in actions {
                if action.title == actionTitle {
                    action.setValue(color, forKey: "titleTextColor")
                }
            }
        }
    }
}
