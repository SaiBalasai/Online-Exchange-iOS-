//
//  CreateListingVC.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 9/13/24.
//

import UIKit

class CreateListingVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productDescriptionTextView: UITextView!
    
    @IBOutlet weak var productPriceTextField: UITextField!
    
    @IBOutlet weak var productNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func uploadImageTapped(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
               imagePickerController.delegate = self
               imagePickerController.sourceType = .photoLibrary // You can set to .camera for camera
               present(imagePickerController, animated: true, completion: nil)
          
        
        
    }
    
    
    @IBAction func submitProductTapped(_ sender: UIButton) {
        
        guard let productName = productNameTextField.text, !productName.isEmpty,
                    let productPriceText = productPriceTextField.text, !productPriceText.isEmpty,
                    let productPrice = Double(productPriceText),
                    let productDescription = productDescriptionTextView.text, !productDescription.isEmpty else {
                  // Show alert if fields are empty
                  let alert = UIAlertController(title: "Missing Information", message: "Please fill in all the fields", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                  present(alert, animated: true, completion: nil)
                  return
              }
              
              // Handle the product creation
              print("Product Created: \(productName), Price: \(productPrice), Description: \(productDescription)")
              // Save to database or handle as needed

              // Navigate back to Home Screen or another screen
              self.navigationController?.popViewController(animated: true)
          }

          // Handle image selection
          func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
              if let selectedImage = info[.originalImage] as? UIImage {
                  productImageView.image = selectedImage
              }
              picker.dismiss(animated: true, completion: nil)
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
