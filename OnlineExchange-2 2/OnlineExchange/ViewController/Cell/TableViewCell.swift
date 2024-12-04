
import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var userid: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var payBtn: UIButton!

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
        
//        guard let productID = product_id else { return }
//        
//        var favorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? [String]()
//        
//        // Check if the product is already in the favorites list
//        if let index = favorites.firstIndex(of: productID) {
//            // If it's already a favorite, remove it
//            favorites.remove(at: index)
//            sender.setImage(UIImage(named: "emptyHeart"), for: .normal)  // Change to empty heart
//        } else {
//            // If it's not a favorite, add it
//            favorites.append(productID)
//            sender.setImage(UIImage(named: "filledHeart"), for: .normal)  // Change to filled heart
//        }
//        
//        // Save the updated favorites list
//        UserDefaults.standard.set(favorites, forKey: "favorites")
//    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
