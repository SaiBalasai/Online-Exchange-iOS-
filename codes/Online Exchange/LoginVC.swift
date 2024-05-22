//
//  LoginVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 5/15/24.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    //var animatedGradient: AnimatedGradientView!
    var rememberMe: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemGray6
        

        email.placeholder = "Enter your email"
        password.placeholder = "Enter your password"
        password.isSecureTextEntry = true // Secure password input
        
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        
        guard let email = email.text, !email.isEmpty,
              let password = password.text, !password.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Error: \(error.localizedDescription)")
            } else {
                self.performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
   
    
    private func setBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
    
    extension UITextField {
        func setPaddingPoints(_ amount: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        func PaddingPoints(_ amount: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
        
    }
    


