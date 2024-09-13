//
//  SettingVC.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 9/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SettingVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var contactInfo: UITextField!
    
    @IBAction func onUpdate(_ sender: UIButton) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let updatedData = [
            "firstname": firstName.text ?? "",
            "lastname": lastName.text ?? "",
            "email": email.text ?? "",
            "phone": contactInfo.text ?? ""
        ]
        
        db.collection("Users").document(userId).updateData(updatedData) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
                self.showAlert(message: "Error updating profile")
            } else {
                self.showAlert(message: "Profile updated successfully")
            }
        }
        
        
    }
    private func showAlert(message: String) {
           let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
    
    
    @IBAction func onLogout(_ sender: UIButton) {
        
        do {
                   try Auth.auth().signOut()
                   // Navigate to login screen
                   self.performSegue(withIdentifier: "logoutToLoginSegue", sender: self)
               } catch let signOutError as NSError {
                   print("Error signing out: %@", signOutError)
               }
           }
           
//           private func showAlert(message: String) {
//               let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
//               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//               present(alert, animated: true, completion: nil)
//        
//    }
    
    

    private var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
        
        // Initialize Firestore
        db = Firestore.firestore()
        
        // Fetch user details
        fetchUserDetails()
    }
    
    private func fetchUserDetails() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        db.collection("Users").document(userId).getDocument { (document, error) in
            if let error = error {
                print("Error fetching user details: \(error.localizedDescription)")
            } else if let document = document, document.exists {
                let data = document.data()
                self.firstName.text = data?["firstname"] as? String ?? ""
                self.lastName.text = data?["lastname"] as? String ?? ""
                self.email.text = data?["email"] as? String ?? ""
                self.contactInfo.text = data?["phone"] as? String ?? ""
            } else {
                print("Document does not exist")
            }
        }
    }
    private func setBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    
//    // Function to style text fields
//       func styleTextField(_ textField: UITextField) {
//           // Add a border and corner radius
//           textField.layer.borderWidth = 1.0
//           textField.layer.borderColor = UIColor.lightGray.cgColor
//           textField.layer.cornerRadius = 8.0
//           
//           // Add padding to the text field
//           let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
//           textField.leftView = padding
//           textField.leftViewMode = .always
//           
//           // Set background color
//           textField.backgroundColor = UIColor.white
//       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

