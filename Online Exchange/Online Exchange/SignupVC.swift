//
//  SignupVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 5/15/24.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class SignupVC: UIViewController {

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = UIColor.systemGray6
            
          
            
           }
    @IBAction func onSignUp(_ sender: Any) {
        guard let firstName = firstname.text, !firstName.isEmpty,
                            let lastName = lastname.text, !lastName.isEmpty,
                            let email = email.text, !email.isEmpty,
                            let phone = phone.text, !phone.isEmpty,
                            let password = password.text, !password.isEmpty,
                            let confirmPassword = confirmPassword.text, !confirmPassword.isEmpty else {
                          showAlert(message: "Please fill in all fields.")
                          return
                      }

                      if password != confirmPassword {
                          showAlert(message: "Passwords do not match.")
                          return
                      }

                      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                          if let error = error {
                              DispatchQueue.main.async {
                                  self.showAlert(message: "Error: \(error.localizedDescription)")
                              }
                          } else {
                              // Registration successful
                              DispatchQueue.main.async {
                                  self.showAlert(message: "User registered successfully!") {
                                      self.navigateToLoginScreen()
                                  }
                              }
                          }
                      }
                  }

                  private func showAlert(message: String, completion: (() -> Void)? = nil) {
                      let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                          completion?()
                      }))
                      present(alert, animated: true, completion: nil)
                  }
                  
                  private func navigateToLoginScreen() {
                    
                      navigationController?.popViewController(animated: true)
                      
                     
                      self.performSegue(withIdentifier: "signUpToLoginSegue", sender: nil)
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
               func setLPaddingPoints(_ amount: CGFloat) {
                   let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
                   self.leftView = paddingView
                   self.leftViewMode = .always
               }
               
               func setRPaddingPoints(_ amount: CGFloat) {
                   let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
                   self.rightView = paddingView
                   self.rightViewMode = .always
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


