//
//  ForgotPasswordVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 5/15/24.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    
    
    @IBAction func onSend(_ sender: UIButton) {
        
        
//        if(email.text!.isEmpty) {
//            globalAlart(message: "Please enter your email id.")
//            return
//        }
//        else{
//            FireStoreManager.shared.getPassword(email: self.email.text!.lowercased(), password: "") { password in
//                print(password)
//            }
//        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
