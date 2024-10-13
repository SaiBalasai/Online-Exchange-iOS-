//
//  FavouriteTVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 10/11/24.
//

import UIKit

class FavouriteTVC: UITableViewController {

    var favoriteProducts: [ProductModel] = []
            
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Fetch favorite products from UserDefaults
            favoriteProducts = UserDefaults.getFavoriteProducts()
            
            // Reload the table view
            tableView.reloadData()
            
//            let favouriteTVC = storyboard?.instantiateViewController(withIdentifier: "FavoriteCell") as! FavouriteTVC
//            navigationController?.pushViewController(favouriteTVC, animated: true)

            
           
            
        }
    
    
    
    @IBAction func back(_ sender: UIButton) {
        
//        //navigationController?.popViewController(animated: true)
//        
//        if navigationController != nil {
//                // It's in a navigation stack, so pop the view controller
//                navigationController?.popViewController(animated: true)
//            } else {
//                // It's presented modally, so dismiss it
//                dismiss(animated: true, completion: nil)
//            }
//        
//    }
//    
//        // MARK: - Table view data source
//        
//        override func numberOfSections(in tableView: UITableView) -> Int {
//            return 1
//        }
//
//        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return favoriteProducts.count
//        }
//        
//        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
//            
//            // Configure the cell with product details
//            let product = favoriteProducts[indexPath.row]
//            cell.textLabel?.text = product.productname
//            cell.detailTextLabel?.text = "Price: \(product.price), Bid: \(product.bidPrice)"
//            
//            return cell
//        }
//        
//        // MARK: - Swipe to Delete (Unfavorite)
//        
//        // Enable swipe actions for rows
//        override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//            return .delete // This enables the swipe-to-delete action
//        }
//    
//    // Handle the row selection to navigate to BidProductVC
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedProduct = favoriteProducts[indexPath.row]  // Get the selected product
//        
//        // Perform segue to BidProductVC and pass the selected product as the sender
//        performSegue(withIdentifier: "showBidProductSegue", sender: selectedProduct)
//    }
//    
//    // Prepare for the segue to pass the selected product to BidProductVC
//    // Prepare for segue
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "showBidProductSegue" {
//                if let bidProductVC = segue.destination as? BidProductVC {
//                    if let product = sender as? ProductModel {
//                        bidProductVC.productData = product // Pass the selected product
//                    }
//                }
//            }
//        
//    }
//
//
//        
//        // Handle the swipe-to-delete action
//        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//            if editingStyle == .delete {
//                // Remove the product from the favorite list
//                let productToRemove = favoriteProducts[indexPath.row]
//                UserDefaults.removeFavoriteProduct(productToRemove)
//                
//                // Update the local favoriteProducts array
//                favoriteProducts.remove(at: indexPath.row)
//                
//                // Remove the row from the table view with an animation
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//        }
//    }
//
//    // Extension for UserDefaults to remove a favorite product
//    extension UserDefaults {
//        private static let favoritesKey = "favoriteProducts"
//        
//        // Remove product from favorites
//        static func removeFavouriteProduct(_ product: ProductModel) {
//            var favorites = getFavoriteProducts()
//            
//            // Remove the product if it's found in the favorites list
//            favorites.removeAll(where: { $0.product_id == product.product_id })
//            
//            let favoritesDictArray = favorites.map { $0.toDictionary() }
//            UserDefaults.standard.set(favoritesDictArray, forKey: favoritesKey)
//        }
//    }

// Navigate back based on the view controller's presentation style
       if navigationController != nil {
           navigationController?.popViewController(animated: true)
       } else {
           dismiss(animated: true, completion: nil)
       }
   }
    

   // MARK: - Table view data source
   
   override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
    

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return favoriteProducts.count
   }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155 + 3 // Original height + top and bottom padding (20 points total)
    }

    
//   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
//       // Configure the cell with product details
//       let product = favoriteProducts[indexPath.row]
//       cell.textLabel?.text = product.productname
//       cell.detailTextLabel?.text = "Price: \(product.price), Bid: \(product.bidPrice)"
//       return cell
//   }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteProductCell
        
        // Get the product for the current index path
        let product = favoriteProducts[indexPath.row]
        
        // Set the product name, quantity, price, and details
        cell.productNameLabel.text = "Product Name: \(product.productname)"
      //  cell.productQuantityLabel.text = "Quantity: \(product.quantity)"
        cell.productPriceLabel.text = "Price: \(product.price)"
      //  cell.productDetailLabel.text = "Detail: \(product.productDetail)"
        
        // Set the product image
        let imageUrl = product.productImageUrl
        cell.productImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "logo"))
        
        // Optional: Style the image view (rounded corners)
            cell.productImageView.layer.cornerRadius = 0
            cell.productImageView.clipsToBounds = true
        
        return cell
    }

   
   // MARK: - Swipe to Delete (Unfavorite)

   override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       return .delete // Enable the swipe-to-delete action
   }
    

   // Handle the swipe-to-delete action
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           let productToRemove = favoriteProducts[indexPath.row]
           // Remove product from UserDefaults
           UserDefaults.removeFavouriteProduct(productToRemove)

           // Update the local favoriteProducts array
           favoriteProducts.remove(at: indexPath.row)

           // Remove the row from the table view with an animation
           tableView.deleteRows(at: [indexPath], with: .fade)
           tableView.reloadData() // Reload data after the removal

       }
   }

   // Handle the row selection to navigate to BidProductVC
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let selectedProduct = favoriteProducts[indexPath.row] // Get the selected product
       // Perform segue to BidProductVC and pass the selected product as the sender
       performSegue(withIdentifier: "showBidProductSegue", sender: selectedProduct)
   }
   
   // Prepare for the segue to pass the selected product to BidProductVC
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "showBidProductSegue" {
           if let bidProductVC = segue.destination as? BidProductVC,
              let product = sender as? ProductModel {
               bidProductVC.productData = product // Pass the selected product
           }
       }
   }
}



// Extension for UserDefaults to manage favorite products
extension UserDefaults {
   private static let favoritesKey = "favoriteProducts"
   
   static func getFavouriteProducts() -> [ProductModel] {
       // Fetch the stored favorites array from UserDefaults
             guard let favoritesDictArray = UserDefaults.standard.array(forKey: favoritesKey) as? [[String: Any]] else {
                 return [] // Return an empty array if nothing is found
             }
             
             // Convert the dictionaries to ProductModel instances, filtering out nil values
             let favorites = favoritesDictArray.compactMap { dict -> ProductModel? in
                 // Ensure that the dictionary can create a valid ProductModel
                 return ProductModel(dictionary: dict)
             }
             return favorites
   }
   
   static func removeFavouriteProduct(_ product: ProductModel) {
       var favorites = getFavoriteProducts()
       // Remove the product from favorites
       favorites.removeAll(where: { $0.product_id == product.product_id })
       // Convert the favorites array to a dictionary array and save it
       let favoritesDictArray = favorites.map { $0.toDictionary() }
       UserDefaults.standard.set(favoritesDictArray, forKey: favoritesKey)
   }
}

    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        // Uncomment the following line to preserve selection between presentations
    //        // self.clearsSelectionOnViewWillAppear = false
    //
    //        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    //    }
    //
    //    // MARK: - Table view data source
    //
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    //
    //    /*
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    //
    //        // Configure the cell...
    //
    //        return cell
    //    }
    //    */
    //
    //    /*
    //    // Override to support conditional editing of the table view.
    //    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        // Return false if you do not want the specified item to be editable.
    //        return true
    //    }
    //    */
    //
    //    /*
    //    // Override to support editing the table view.
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            // Delete the row from the data source
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        } else if editingStyle == .insert {
    //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //        }
    //    }
    //    */
    //
    //    /*
    //    // Override to support rearranging the table view.
    //    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    //
    //    }
    //    */
    //
    //    /*
    //    // Override to support conditional rearranging of the table view.
    //    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    //        // Return false if you do not want the item to be re-orderable.
    //        return true
    //    }
    //    */
    //
    //    /*
    //    // MARK: - Navigation
    //
    //    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // Get the new view controller using segue.destination.
    //        // Pass the selected object to the new view controller.
    //    }
    //    */
    //
    //}

