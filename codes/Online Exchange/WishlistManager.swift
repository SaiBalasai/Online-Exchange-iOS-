//
//  WishlistManager.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 9/12/24.
//

import Foundation

class WishlistManager {
    static let shared = WishlistManager()
    private init() {}
    
    private(set) var wishlist: [Product] = []
    
    func addToWishlist(_ product: Product) {
        if !wishlist.contains(where: { $0.name == product.name }) {
            wishlist.append(product)
        }
    }
    
    func removeFromWishlist(_ product: Product) {
        wishlist.removeAll { $0.name == product.name }
    }
    
    func isProductInWishlist(_ product: Product) -> Bool {
        return wishlist.contains(where: { $0.name == product.name })
    }
}
