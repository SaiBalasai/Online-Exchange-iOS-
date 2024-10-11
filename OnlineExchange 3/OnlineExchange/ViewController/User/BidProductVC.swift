

import UIKit
import SDWebImage

class BidProductVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var detailTxt: UITextView!
    @IBOutlet weak var productNameTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var quantityTxt: UITextField!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var bidpriceTxt: UITextField!
    @IBOutlet weak var highestbidpriceTxt: UITextField!
    
    var productData: ProductModel?
       var bidPrice = Int()
       
       var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               self.showProductData()
               self.updateFavoriteButtonState() // Update button state based on favorite status
               
               bidpriceTxt.delegate = self
        
    }
    
    func showProductsData() {
        // Show product details
        self.productNameTxt.text = productData?.productname
        self.priceTxt.text = productData?.price
        self.quantityTxt.text = productData?.quantity
        self.detailTxt.text = productData?.productDetail
        self.highestbidpriceTxt.text = productData?.bidPrice
        
        // Load the product image
        let imageUrl = productData?.productImageUrl ?? ""
        self.productimage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "logo"))
        
        // Update the bid price
        bidPrice = Int(productData?.bidPrice ?? "0") ?? 0

        // Check if the product is already in favorites and update the button accordingly
        if let product = productData, UserDefaults.getFavoriteProducts().contains(where: { $0.product_id == product.product_id }) {
            // Product is in favorites, show filled heart
            fav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            // Product is not in favorites, show empty heart
            fav.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    
//    func showProductData(){
//        self.productNameTxt.text = productData?.productname
//        self.priceTxt.text = productData?.price
//        self.quantityTxt.text = productData?.quantity
//        self.detailTxt.text = productData?.productDetail
//        self.highestbidpriceTxt.text = productData?.bidPrice
//        
//        let imageUrl = productData?.productImageUrl ?? ""
//        
//        self.productimage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "logo"))
//        
//        bidPrice = Int(productData?.bidPrice ?? "0") ?? 0
//    }
    
    func showProductData(){
            self.productNameTxt.text = productData?.productname
            self.priceTxt.text = productData?.price
            self.quantityTxt.text = productData?.quantity
            self.detailTxt.text = productData?.productDetail
            self.highestbidpriceTxt.text = productData?.bidPrice
            
            let imageUrl = productData?.productImageUrl ?? ""
            
            self.productimage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "logo"))
            
            bidPrice = Int(productData?.bidPrice ?? "0") ?? 0
            
            // Check if this product is already favorited
            if let product = productData, UserDefaults.isProductFavorited(product) {
                isFavorite = true
            }
            updateFavoriteButtonState()
        }
    
    func updateFavoriteButtonState() {
            if isFavorite {
                fav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                fav.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    
    @IBAction func favourite(_ sender: UIButton) {
        
        guard let product = productData else { return }
                
                // Toggle favorite status
                if isFavorite {
                    // If it's already a favorite, remove it
                    UserDefaults.removeFavoriteProduct(product)
                    isFavorite = false
                    showAlerOnTop(message: "\(product.productname) has been removed from your favorites.")
                } else {
                    // Otherwise, add it to favorites
                    UserDefaults.saveFavoriteProduct(product)
                    isFavorite = true
                    showAlerOnTop(message: "\(product.productname) has been added to your favorites.")
                }
                
                // Update the button appearance
                updateFavoriteButtonState()

        
    }
    
    
    @IBOutlet weak var fav: UIButton!
    
    
    @IBAction func btnAddBid(_ sender: UIButton) {
        guard let text = bidpriceTxt.text, let enteredPrice = Int(text) else {
            showAlerOnTop(message: "Please enter bid amount.")
            return
        }
        
        if enteredPrice > bidPrice {
            print("Valid price entered: \(enteredPrice). Proceeding...")
            
            if(bidpriceTxt.text!.isEmpty) {
                showAlerOnTop(message: "Please enter bid price")
                return
                
            } else {
                
                let data = ProductModel(productname: self.productData?.productname ?? "", adminId: self.productData?.adminId ?? "", price: self.productData?.price ?? "", quantity: self.quantityTxt.text ?? "", productImageUrl: self.productData?.productImageUrl ?? "", userId: UserDefaultsManager.shared.getDocumentId(), availableQuantity: self.productData?.availableQuantity ?? "", productDetail: self.productData?.productDetail ?? "",adminEmail: self.productData?.adminEmail ?? "",userEmail: UserDefaultsManager.shared.getEmail(), product_id: self.productData?.product_id ?? "", bidPrice: self.bidpriceTxt.text ?? "")
                
                let productDocumentId = "\(self.productData?.productname ?? "")-\(self.productData?.price ?? "")-\(self.productData?.quantity ?? "")-\(UserDefaultsManager.shared.getDocumentId())"
                
                FireStoreManager.shared.processProductRequestAndUpdateBid(documentID: UserDefaultsManager.shared.getDocumentId(), adminId: self.productData?.adminId ?? "", product: data, newBidPrice: self.bidpriceTxt.text ?? "", bidproduct_id: self.productData?.product_id ?? "", productDocumentId: productDocumentId) { success in
                    if success {
                        showAlerOnTop(message: "Place bid successfully. Request send to admin")
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        showAlerOnTop(message: "You already placed bid for this item.")
                    }
                }
            }
        } else {
            
            showAlerOnTop(message: "Price must be greater than \(self.highestbidpriceTxt.text ?? "") rupees.")
        }
    }
}
extension UserDefaults {
    private static let favoritesKey = "favoriteProducts"
    
    // Save product as dictionary
    static func saveFavoriteProduct(_ product: ProductModel) {
        var favorites = getFavoriteProducts()
        
        // Ensure the product isn't already in the favorites list
        if !favorites.contains(where: { $0.product_id == product.product_id }) {
            favorites.append(product)
            let favoritesDictArray = favorites.map { $0.toDictionary() }
            UserDefaults.standard.set(favoritesDictArray, forKey: favoritesKey)
        }
    }
    
    // Retrieve favorite products
    static func getFavoriteProducts() -> [ProductModel] {
        if let dataArray = UserDefaults.standard.array(forKey: favoritesKey) as? [[String: Any]] {
            return dataArray.compactMap { ProductModel(dictionary: $0) }
        }
        return []
    }
    
    // Remove product from favorites
    static func removeFavoriteProduct(_ product: ProductModel) {
        var favorites = getFavoriteProducts()
        
        // Remove the product if it's found in the favorites list
        favorites.removeAll(where: { $0.product_id == product.product_id })
        
        let favoritesDictArray = favorites.map { $0.toDictionary() }
        UserDefaults.standard.set(favoritesDictArray, forKey: favoritesKey)
    }
    
    // Check if the product is favorited
    static func isProductFavorited(_ product: ProductModel) -> Bool {
        let favorites = getFavoriteProducts()
        return favorites.contains(where: { $0.product_id == product.product_id })
    }
}



