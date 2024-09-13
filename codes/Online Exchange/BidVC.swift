//
//  BidVC.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 9/12/24.
//

import UIKit

class BidVC: UIViewController {

    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var bidAmountTextField: UITextField!
    
    @IBOutlet weak var placeBidButton: UIButton!
    
    
    @IBOutlet weak var currentBidLabel: UILabel!
    
    
    
    @IBAction func placeBidTapped(_ sender: UIButton) {
        
        guard let bidAmountText = bidAmountTextField.text, let bidAmount = Int(bidAmountText), bidAmount > currentBidAmount else {
               // Show an alert if the bid amount is invalid or not greater than the current bid
               let alert = UIAlertController(title: "Invalid Bid", message: "Please enter a bid amount greater than the current bid.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           
           // Handle the bid submission
           print("Bid of \(bidAmount) placed for \(selectedProduct?.name ?? "")")
           
           // Update the current bid amount
           currentBidAmount = bidAmount
           updateCurrentBidLabel()
           
           // Navigate to BidConfirmationVC
           if let confirmationVC = storyboard?.instantiateViewController(withIdentifier: "BidConfirmationVC") as? BidConfirmationVC {
               confirmationVC.productName = selectedProduct?.name
               confirmationVC.productImage = productImageView.image
               confirmationVC.bidAmount = bidAmount
               navigationController?.pushViewController(confirmationVC, animated: true)
           }
                  }
        
    
    
    
    var currentBidAmount: Int = 0
    var selectedProduct: Product? // This will hold the passed product

    override func viewDidLoad() {
        super.viewDidLoad()
                
                if let product = selectedProduct {
                    productNameLabel.text = product.name
                    productImageView.image = UIImage(named: product.imageName)
                    // Set the current bid amount (fetch this from your data source)
                    currentBidAmount = fetchCurrentBidAmount(for: product) // Example method
                    updateCurrentBidLabel()
                }
                
                // Set keyboard type for the bid amount text field to number pad
                bidAmountTextField.keyboardType = .numberPad
                bidAmountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                
                // Initially disable the button until user inputs a bid amount greater than the current bid
                placeBidButton.isEnabled = false
            }

            func fetchCurrentBidAmount(for product: Product) -> Int {
                // Replace with actual logic to fetch the current bid amount for the product
                return 100 // Example value
            }

            func updateCurrentBidLabel() {
                currentBidLabel.text = "Current Bid: $\(currentBidAmount)"
            }

        
    @objc func textFieldDidChange(_ textField: UITextField) {
        // Validate if the text field contains a numeric value greater than the current bid amount
               if let text = textField.text, let bidAmount = Int(text), bidAmount > currentBidAmount {
                   placeBidButton.isEnabled = true
               } else {
                   placeBidButton.isEnabled = false
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

}
