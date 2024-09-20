
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

    init(productname: String, adminId: String, price: String, quantity: String, productImageUrl: String, userId: String, availableQuantity: String, productDetail: String) {
        self.productname = productname
        self.adminId = adminId
        self.price = price
        self.quantity = quantity
        self.productImageUrl = productImageUrl
        self.userId = userId
        self.availableQuantity = availableQuantity
        self.productDetail = productDetail
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
            "productDetail": productDetail
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
    }
}
