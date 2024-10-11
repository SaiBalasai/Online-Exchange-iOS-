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
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteProducts.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
            
            // Configure the cell with product details
            let product = favoriteProducts[indexPath.row]
            cell.textLabel?.text = product.productname
            cell.detailTextLabel?.text = "Price: \(product.price), Bid: \(product.bidPrice)"
            
            return cell
        }
        
        // MARK: - Swipe to Delete (Unfavorite)
        
        // Enable swipe actions for rows
        override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete // This enables the swipe-to-delete action
        }
        
        // Handle the swipe-to-delete action
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Remove the product from the favorite list
                let productToRemove = favoriteProducts[indexPath.row]
                UserDefaults.removeFavoriteProduct(productToRemove)
                
                // Update the local favoriteProducts array
                favoriteProducts.remove(at: indexPath.row)
                
                // Remove the row from the table view with an animation
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    // Extension for UserDefaults to remove a favorite product
    extension UserDefaults {
        private static let favoritesKey = "favoriteProducts"
        
        // Remove product from favorites
        static func removeFavouriteProduct(_ product: ProductModel) {
            var favorites = getFavoriteProducts()
            
            // Remove the product if it's found in the favorites list
            favorites.removeAll(where: { $0.product_id == product.product_id })
            
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

