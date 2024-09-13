//
//  BidConfirmationVC.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 9/12/24.
//

import UIKit

class BidConfirmationVC: UIViewController {

    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    @IBOutlet weak var bidAmountLabel: UILabel!
    
    @IBOutlet weak var congratulationsLabel: UILabel!
    
    
    var productName: String?
        var productImage: UIImage?
        var bidAmount: Int?

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set UI elements with data passed from BidVC
            productNameLabel.text = productName
            productImageView.image = productImage
            bidAmountLabel.text = "Bid Amount: $\(bidAmount ?? 0)"
            congratulationsLabel.text = "Congratulations! You have placed the highest bid for \(productName ?? "this item")."
                
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
