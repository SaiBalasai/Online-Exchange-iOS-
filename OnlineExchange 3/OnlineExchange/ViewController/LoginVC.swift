//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginVC: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        //setupLoginButton()
            }
            
            private func setupLoginButton() {
                // Set the button's background color
                loginButton.backgroundColor = UIColor.systemGreen
                
                // Set the button's title color
                loginButton.setTitleColor(.white, for: .normal)
                
                // Set the corner radius to make the button capsule-shaped
                loginButton.layer.cornerRadius = loginButton.frame.height / 2
                
                // Optional: Set border width and color
               // loginButton.layer.borderWidth = 1
               // loginButton.layer.borderColor = UIColor.white.cgColor
                
                // Ensure the button has a fixed height if necessary
                loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            }
    
    @IBOutlet weak var loginButton: ButtonLayerSetup!
    
    
    
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
                FireStoreManager.shared.login(email: email.text?.lowercased() ?? "", password: password.text ?? "") { success in
                    if success{
                        let userType = UserDefaultsManager.shared.getUserType()
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
