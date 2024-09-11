//
//  SettingVC.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 9/10/24.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var contactInfo: UITextField!
    
    @IBAction func onUpdate(_ sender: UIButton) {
    }
    
    @IBAction func onLogout(_ sender: UIButton) {
    }
    
    
    var password = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
        
//        styleTextField(email)
//               styleTextField(firstName)
//               styleTextField(lastName)
//               styleTextField(contactInfo)

        // Do any additional setup after loading the view.
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

