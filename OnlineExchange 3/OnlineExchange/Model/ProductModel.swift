
import Foundation

struct ProductModel {
    let productname: String
    let adminId: String
    let price: String
    let quantity: String
    let productImageUrl: String
    let userId: String
    let availableQuantity: String
    let productDetail: String
    let adminEmail: String
    let userEmail: String
    var product_id: String
    var bidPrice: String

    init(productname: String, adminId: String, price: String, quantity: String, productImageUrl: String, userId: String, availableQuantity: String, productDetail: String, adminEmail: String, userEmail: String, product_id: String, bidPrice: String) {
        self.productname = productname
        self.adminId = adminId
        self.price = price
        self.quantity = quantity
        self.productImageUrl = productImageUrl
        self.userId = userId
        self.availableQuantity = availableQuantity
        self.productDetail = productDetail
        self.product_id = product_id
        self.adminEmail = adminEmail
        self.bidPrice = bidPrice
        self.userEmail = userEmail
    }

    func toDictionary() -> [String: Any] {
        return [
            "productname": productname,
            "adminId": adminId,
            "price": price,
            "quantity": quantity,
            "productImageUrl": productImageUrl,
            "userId": userId,
            "availableQuantity": availableQuantity,
            "productDetail": productDetail,
            "product_id": product_id,
            "adminEmail": adminEmail,
            "bidPrice": bidPrice,
            "userEmail": userEmail
        ]
    }
    
    init?(dictionary: [String: Any]) {
        guard let productname = dictionary["productname"] as? String,
              let adminId = dictionary["adminId"] as? String,
              let price = dictionary["price"] as? String,
              let quantity = dictionary["quantity"] as? String,
              let productImageUrl = dictionary["productImageUrl"] as? String,
              let availableQuantity = dictionary["availableQuantity"] as? String,
              let productDetail = dictionary["productDetail"] as? String,
              let product_id = dictionary["product_id"] as? String,
              let adminEmail = dictionary["adminEmail"] as? String,
              let userEmail = dictionary["userEmail"] as? String,
              let bidPrice = dictionary["bidPrice"] as? String,
              let userId = dictionary["userId"] as? String else {
            return nil
        }
        
        self.productname = productname
        self.adminId = adminId
        self.price = price
        self.quantity = quantity
        self.productImageUrl = productImageUrl
        self.userId = userId
        self.availableQuantity = availableQuantity
        self.productDetail = productDetail
        self.product_id = product_id
        self.adminEmail = adminEmail
        self.userEmail = userEmail
        self.bidPrice = bidPrice
    }
}
