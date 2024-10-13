//
//  FavoriteProductCell.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 10/12/24.
//

import UIKit

class FavoriteProductCell: UITableViewCell {
    
    
    private let topBorderView = UIView()
    private let bottomBorderView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.layer.cornerRadius = 0
        self.contentView.clipsToBounds = true
        
        // Setup top border
        topBorderView.backgroundColor = UIColor(hex: "#95BA9D")
        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topBorderView)
        
        // Setup bottom border
        bottomBorderView.backgroundColor = UIColor(hex: "#95BA9D")
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bottomBorderView)
        
        // Constraints for top border
        NSLayoutConstraint.activate([
            topBorderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topBorderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topBorderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topBorderView.heightAnchor.constraint(equalToConstant: 4) // Height of the top border
        ])
        
        // Constraints for bottom border
        NSLayoutConstraint.activate([
            bottomBorderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 1) // Height of the bottom border
        ])
        
        // Optional: Add padding to labels
        productNameLabel.layer.masksToBounds = true
        productPriceLabel.layer.masksToBounds = true
    }
    
    
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    // Initialization code
    
    //        self.contentView.layer.cornerRadius = 0
    //               self.contentView.layer.borderWidth = 4
    //               self.contentView.layer.borderColor = UIColor.lightGray.cgColor
    //               self.contentView.layer.shadowColor = UIColor.black.cgColor
    //               self.contentView.layer.shadowOpacity = 0.1
    //               self.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
    //               self.contentView.layer.shadowRadius = 4
    //               self.contentView.clipsToBounds = true
    //
    //               // Optional: Add padding to labels
    //               productNameLabel.layer.masksToBounds = true
    //               //productQuantityLabel.layer.masksToBounds = true
    //               productPriceLabel.layer.masksToBounds = true
    //              // productDetailLabel.layer.masksToBounds = true
    
    // Remove border color and width for the sides
    //              self.contentView.layer.cornerRadius = 0
    //              self.contentView.layer.borderWidth = 0 // Set to 0 to remove the border
    //        self.contentView.layer.borderColor = UIColor.green.cgColor // Set border color to clear
    //              self.contentView.layer.shadowColor = UIColor.black.cgColor
    //              self.contentView.layer.shadowOpacity = 0.1
    //              self.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
    //              self.contentView.layer.shadowRadius = 4
    //              self.contentView.clipsToBounds = true
    //
    //              // Optional: Add padding to labels
    //              productNameLabel.layer.masksToBounds = true
    //              // productQuantityLabel.layer.masksToBounds = true
    //              productPriceLabel.layer.masksToBounds = true
    //              // productDetailLabel.layer.masksToBounds = true
    //
    //    }
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
