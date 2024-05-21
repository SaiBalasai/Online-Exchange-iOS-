//
//  SignupVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 5/15/24.
//

import UIKit
import Firebase
import FirebaseFirestore

class SignupVC: UIViewController {

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       }
    
    @IBAction func onSignUp(_ sender: Any) {
//        if validate() {
//
//            let userData = UserRegistrationModel(firstname: self.firstname.text ?? "", lastname: self.lastname.text ?? "", email: self.email.text ?? "", phone: self.phone.text ?? "", password: self.password.text ?? "")
//            
//            FireStoreManager.shared.signUp(user: userData) { success in
//                if success{
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }
//        }
        
    }

    
    func validate() ->Bool {
       
//        if(self.email.text!.isEmpty) {
//            globalAlart(message: "Please enter email.")
//            return false
//        }
//        
//        if !email.text!.emailIsCorrect() {
//            globalAlart(message: "Please enter valid email id")
//            return false
//        }
//    
//              
//        if(self.password.text!.isEmpty) {
//            globalAlart(message: "Please enter password.")
//            return false
//        }
//        
//        if(self.confirmPassword.text!.isEmpty) {
//            globalAlart(message: "Please enter confirm password.")
//            return false
//        }
//        
//           if(self.password.text! != self.confirmPassword.text!) {
//               globalAlart(message: "Password doesn't match")
//            return false
//        }
//        
//        if(self.password.text!.count < 5 || self.password.text!.count > 10 ) {
//            
//            globalAlart(message: "Password  length shoud be 5 to 10")
//            return false
//        }
//        
//        if(self.firstname.text!.isEmpty) {
//            globalAlart(message: "Please enter first name.")
//            return false
//        }
//        
//        if(self.lastname.text!.isEmpty) {
//            globalAlart(message: "Please enter last name.")
//            return false
//        }
//        
//        if(self.phone.text!.isEmpty) {
//            globalAlart(message: "Please enter phone.")
//            return false
//        }
//        
        return true
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
