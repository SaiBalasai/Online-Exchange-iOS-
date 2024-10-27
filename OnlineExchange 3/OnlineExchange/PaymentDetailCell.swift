//
//  PaymentDetailCell.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 10/14/24.
//

import UIKit

class PaymentDetailCell: UITableViewCell {
    
    // UI Elements
    var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var itemQuantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(itemImage)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemPriceLabel)
        contentView.addSubview(itemQuantityLabel)
        
        // Setup constraints
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        // Constraints for itemImage
        NSLayoutConstraint.activate([
            itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImage.widthAnchor.constraint(equalToConstant: 60),
            itemImage.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Constraints for itemNameLabel
        NSLayoutConstraint.activate([
            itemNameLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 16),
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // Constraints for itemPriceLabel
        NSLayoutConstraint.activate([
            itemPriceLabel.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
            itemPriceLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 4)
        ])
        
        // Constraints for itemQuantityLabel
        NSLayoutConstraint.activate([
            itemQuantityLabel.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
            itemQuantityLabel.topAnchor.constraint(equalTo: itemPriceLabel.bottomAnchor, constant: 4),
            itemQuantityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
