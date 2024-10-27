//
//  PaymentViewController.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 10/14/24.
//

import UIKit

class PaymentViewController: UIViewController{
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailCell", for: indexPath) as! PaymentDetailCell
    //        return cell
    //    }
    
    
    
    
    var product: ProductModel! // Property to hold the product details
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //  setupTableView()
        setupProductDetails()
        
    }
    
    private func setupUI() {
        // Ensure product is not nil before accessing its properties
        guard let product = product else { return }
        totalPrice.text = "Total Price: \(product.bidPrice)" // Set the total price
    }
    
    private func setupTableView() {
        //tableview.delegate = self
        // tableview.dataSource = self
        // tableview.register(PaymentDetailCell.self, forCellReuseIdentifier: "PaymentDetailCell") // Register the cell class
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    
    
    
    
    
    
    
    @IBOutlet weak var totalPrice: UILabel!
    
    
    @IBAction func creditCardNumber(_ sender: UITextField) {
    }
    
    
    @IBAction func cvv(_ sender: UITextField) {
    }
    
    
    @IBAction func expiry(_ sender: UITextField) {
    }
    
    @IBOutlet weak var cardNumber: UITextField!
    
    @IBOutlet weak var cvvNumber: UITextField!
    
    @IBOutlet weak var cardExpiry: UITextField!
    
    @IBAction func payment(_ sender: UIButton) {
        
        // Show loader while simulating payment processing
           let loader = UIActivityIndicatorView(style: .large)
           loader.center = self.view.center
           loader.startAnimating()
           self.view.addSubview(loader)
           
           // Simulate payment processing (replace with actual payment logic)
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               loader.stopAnimating() // Stop the loader after 2 seconds
               
               // Generate a random transaction ID
               let transactionId = UUID().uuidString
               
               // Clean the bidPrice by removing non-numeric characters like "$"
               let cleanedBidPrice = self.product.bidPrice.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
               
               // Convert bidPrice to Double if possible
               if let bidPriceDouble = Double(cleanedBidPrice) {
                   // Navigate to ReceiptViewController after payment is successful
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   if let receiptVC = storyboard.instantiateViewController(withIdentifier: "ReceiptViewController") as? ReceiptViewController {
                       receiptVC.transactionID = transactionId // Pass transaction ID
                       receiptVC.total = bidPriceDouble // Pass total price as Double
                       
                       // Show alert with success message and emoji
                       let alert = UIAlertController(title: "Purchase Successful 🎉", message: "Your product has been purchased successfully!", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                           // Navigate to receipt screen after user dismisses the alert
                           self.navigationController?.pushViewController(receiptVC, animated: true)
                       }))
                       
                       // Present the alert
                       self.present(alert, animated: true, completion: nil)
                   } else {
                       print("ReceiptViewController not found")
                   }
               } else {
                   print("Error: Invalid bidPrice, could not convert to Double")
               }
           }
        }
        
        
        
        @IBOutlet weak var pay: UIButton!
        
        func setupProductDetails() {
            guard let product = product else { return }
            
            // Setting the product details in the UI elements
            productNameLabel.text = product.productname
            productPriceLabel.text = "Price: \(product.bidPrice)"
            productQuantityLabel.text = "Quantity: \(product.quantity)"
            
            // Directly use product.productImageUrl without optional binding
            let imageUrl = URL(string: product.productImageUrl)
            productImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholderImage"))
        }
        
        
        
        
        
        
        @IBAction func back(_ sender: UIButton) {
            // Implement back action
            navigationController?.popViewController(animated: true)
        }
        
        
        //extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
        // MARK: - UITableViewDataSource Methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1 // Only one product detail to display
        }
        
        //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailCell", for: indexPath) as! PaymentDetailCell
        //
        //        // Set product details without the image
        //        cell.itemNameLabel.text = product.productname
        //        cell.itemPriceLabel.text = "Price: \(product.bidPrice)"
        //        cell.itemQuantityLabel.text = "Quantity: \(product.quantity)"
        //
        //        return cell
        //    }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
        
        
        
    
}
