//
//  ForgotPasswordVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 5/15/24.
//

import UIKit
import FirebaseAuth

class ForgotPasswordVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
        self.view.backgroundColor = UIColor.systemGray6
    }
    //    
    //    private func setupUI() {
    //        // Email TextField Styling
    //        email.placeholder = "Enter your email address"
    //        email.layer.borderColor = UIColor.lightGray.cgColor
    //        email.layer.borderWidth = 1.0
    //        email.layer.cornerRadius = 8.0
    //        email.layer.masksToBounds = true
    //        email.setLeftPaddingPoints(10)
    //        email.setRightPaddingPoints(10)
    
    // Send Button Styling
    //        sendButton.backgroundColor = UIColor.systemBlue
    //        sendButton.setTitleColor(.white, for: .normal)
    //        sendButton.layer.cornerRadius = 8.0
    //        sendButton.layer.masksToBounds = true
    //        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    //}
    
    
    
    
    
    @IBOutlet weak var email: UITextField!
    
    
    
    @IBAction func onSend(_ sender: UIButton) {
        
        
        guard let email = email.text, !email.isEmpty else {
            showAlert(message: "Please enter your email address.")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(message: "Error resetting password: \(error.localizedDescription)")
                } else {
                    self.showAlert(message: "A password reset email has been sent to \(email). Please check your inbox and follow the instructions to reset your password.")
                }
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

       // Extensions for padding in UITextField
       extension UITextField {
           func setLeftPaddingPoints(_ amount: CGFloat) {
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
               self.leftView = paddingView
               self.leftViewMode = .always
           }
           func setRightPaddingPoints(_ amount: CGFloat) {
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
               self.rightView = paddingView
               self.rightViewMode = .always
           }
       
        
        
    
        
        
       

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
