//
//  AcceptedRequestVC.swift
//  OnlineExchange
//
//  Created by Macbook-Pro on 18/09/24.
//

import UIKit

class AcceptedRequestVC: BaseViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var productsRequest: [ProductModel] = []

    
    @IBAction func buy(_ sender: UIButton) {
        
        
        let tag = sender.tag
           guard tag >= 0 && tag < productsRequest.count else { return }
        //print("Navigating to PaymentVC with product: \(product.productname)")

           // Get the product corresponding to the selected row
           let product = productsRequest[tag]
           
           // Initialize PaymentVC from the storyboard
           if let paymentVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as? PaymentViewController {
               paymentVC.product = product  // Pass the correct product data
               
               // Navigate to PaymentVC
               self.navigationController?.pushViewController(paymentVC, animated: true)
           }
      
//        let tag = sender.tag
//            guard tag >= 0 && tag < productsRequest.count else { return }
//            
//            // Get the product corresponding to the selected row
//            let product = productsRequest[tag]
//            
//            // Initialize PaymentVC from the storyboard
//            if let paymentVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as? PaymentViewController {
//                paymentVC.product = product  // Pass the product data
//                
//                // Navigate to PaymentVC
//                self.navigationController?.pushViewController(paymentVC, animated: true)
//            }
      
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.fetchProductData()
        
        
        
    }

    func fetchProductData() {
        FireStoreManager.shared.getAllRequestProductRecord(forUserId: UserDefaultsManager.shared.getDocumentId(), collectionStatus: "BidAcceptedByOwnerOfUser") { [weak self] fetchedProducts, error in
              if let error = error {
                  print("Error fetching products: \(error.localizedDescription)")
              } else if let fetchedProducts = fetchedProducts {
                  self?.productsRequest = fetchedProducts
                  self?.tableView.reloadData()
              }
          }
      }
    
}


extension AcceptedRequestVC {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsRequest.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
//       
//        let data = self.productsRequest[indexPath.row]
//        cell.productName.text = "Product Name: \(data.productname)"
//        cell.quantity.text = "Quantity: \(data.quantity)"
//        cell.price.text = "Bid Price: \(data.bidPrice)"
//        cell.productDetail.text = "Detail: \(data.productDetail)"
//        
//        let imageUrl = data.productImageUrl
//
//        cell.productImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "logo"))
//        
//        cell.acceptBtn.tag = indexPath.row
//        cell.acceptBtn.addTarget(self, action: #selector(self.acceptAppointmentStatus(_:)), for: .touchUpInside)
//
//        
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
       
        let data = self.productsRequest[indexPath.row]
        cell.productName.text = "Product Name: \(data.productname)"
        cell.quantity.text = "Quantity: \(data.quantity)"
        cell.price.text = "Bid Price: \(data.bidPrice)"
        cell.productDetail.text = "Detail: \(data.productDetail)"
        
        let imageUrl = data.productImageUrl
        cell.productImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "logo"))
        
        // Setting the tag so the button can identify the correct product
        cell.acceptBtn.tag = indexPath.row
        cell.acceptBtn.addTarget(self, action: #selector(self.buy(_:)), for: .touchUpInside) // Trigger buy function with correct tag
        
        return cell
    }

    
    @objc func acceptAppointmentStatus(_ sender: UIButton) {
        
        let data = productsRequest[sender.tag]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.chatID = getChatID(email1: data.adminEmail, email2: data.userEmail)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
    }
}
