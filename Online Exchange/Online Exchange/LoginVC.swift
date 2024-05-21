//
//  LoginVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 5/15/24.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    //var animatedGradient: AnimatedGradientView!
    var rememberMe: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      }

//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        
//        // Update the frame of the animated gradient view when the device rotates
//        coordinator.animate(alongsideTransition: { _ in
//            self.animatedGradient?.frame = CGRect(origin: CGPoint.zero, size: size)
//        }, completion: nil)
//    }


    
    @IBAction func onLogin(_ sender: Any) {
//        if(email.text!.isEmpty) {
//            globalAlart(message: "Please enter your email id.")
//            return
//        }
//        
//        if(self.password.text!.isEmpty) {
//            globalAlart(message: "Please enter your password.")
//            return
//        }
//        else{
//            FireStoreManager.shared.login(email: email.text?.lowercased() ?? "", password: password.text ?? "") { success in
//                if success{
//                    SceneDelegate.shared?.loginCheckOrRestart()
//                  //  AudioServicesPlaySystemSound(1105)
//                }
                
           // }
        //}
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
