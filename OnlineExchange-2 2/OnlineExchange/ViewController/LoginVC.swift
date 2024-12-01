//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginVC: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onLogin(_ sender: Any) {
            if(email.text!.isEmpty) {
                showAlerOnTop(message: "Please enter your email id.")
                return
            }

            if(self.password.text!.isEmpty) {
                showAlerOnTop(message: "Please enter your password.")
                return
            }
            else{
                FireStoreManager.shared.login(email: email.text?.lowercased() ?? "", password: (password.text ?? "").encryptStr) { success in
                    if success{
                       // let userType = UserDefaultsManager.shared.getUserType()
                        SceneDelegate.shared?.openHomeOrLogin()
                    }
                }
            }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  "SignupSelectionVC" ) as! SignupSelectionVC
                
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onShowHidePassword(_ sender: UIButton) {
        let buttonImageName = password.isSecureTextEntry ? "eye" : "eye.slash"
            if let buttonImage = UIImage(systemName: buttonImageName) {
                sender.setImage(buttonImage, for: .normal)
        }
        self.password.isSecureTextEntry.toggle()
    }
    
}

extension LoginVC {

    @IBAction func onForgotPassword(_ sender: Any) {
        // Show alert to take email input
        let alert = UIAlertController(title: "Forgot Password", message: "Enter your registered email address to recover your password.", preferredStyle: .alert)

        // Add a text field for email input
        alert.addTextField { textField in
            textField.placeholder = "Email Address"
            textField.keyboardType = .emailAddress
        }

        // Add "Cancel" action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // Add "Submit" action
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            // Get email from the text field
            let email = alert.textFields?.first?.text ?? ""

            // Validate email
            if self.isValidEmail(email) {
                // Call forgotPassword function

                FireStoreManager.shared.forgotPassword(email: email.lowercased()) { success in
                    if success {
                        // Show success alert
                        showAlerOnTop(message: "Password recovery email has been sent.")
                    } else {
                        // Show failure alert
                       showAlerOnTop(message: "Failed to recover password. Please try again.")
                    }
                }
            } else {
                // Show validation error
              showAlerOnTop(message: "Please enter a valid email address.")
            }
        }))

        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }

    /// Helper function to validate email
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
