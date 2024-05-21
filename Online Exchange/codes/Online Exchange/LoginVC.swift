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
           
           // Set placeholder text
           email.placeholder = "Enter your email"
           password.placeholder = "Enter your password"
           password.isSecureTextEntry = true // Secure password input
           
           // Style the text fields
           styleTextField(email)
           styleTextField(password)
           
           // Style the login button
           //styleButton(loginButton)
           
           // Set a gradient background
           setGradientBackground()
           
           // Any additional setup can go here
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
            
            // Function to style text fields
            private func styleTextField(_ textField: UITextField) {
                textField.layer.cornerRadius = 10
                textField.layer.borderWidth = 0
                textField.layer.shadowColor = UIColor.black.cgColor
                textField.layer.shadowOpacity = 0.1
                textField.layer.shadowOffset = CGSize(width: 0, height: 2)
                textField.layer.shadowRadius = 4
                textField.backgroundColor = UIColor.white
                
                // Add padding
                let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
                textField.leftView = leftPaddingView
                textField.leftViewMode = .always
                
                let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
                textField.rightView = rightPaddingView
                textField.rightViewMode = .always
            }
            
            // Function to style buttons
            private func styleButton(_ button: UIButton) {
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
                gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
                gradientLayer.frame = button.bounds
                gradientLayer.cornerRadius = 10
                button.layer.insertSublayer(gradientLayer, at: 0)
                
                button.setTitleColor(UIColor.white, for: .normal)
                button.layer.cornerRadius = 10
                button.layer.masksToBounds = true
                
                // Add shadow
                button.layer.shadowColor = UIColor.black.cgColor
                button.layer.shadowOpacity = 0.2
                button.layer.shadowOffset = CGSize(width: 0, height: 3)
                button.layer.shadowRadius = 5
            }
            
            // Function to set a gradient background
            private func setGradientBackground() {
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 1, y: 1)
                gradientLayer.frame = self.view.bounds
                self.view.layer.insertSublayer(gradientLayer, at: 0)
            }
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


