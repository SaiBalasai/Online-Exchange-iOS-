//
//  ReceiptViewController.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 10/14/24.
//

import UIKit

class ReceiptViewController: UIViewController {

    var transactionID: String!
    
    struct Item {
        var name: String
        var price: Double
        var quantity: Int
        var productID: String // Adding product ID
        var description: String // Adding product description
    }
    
    var items: [Item]!
    var total: Double!
    
    var productss: [ProductModel]! = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Debugging output
        print("Transaction ID: \(transactionID ?? "No Transaction ID")")
        print("Total: \(total ?? 0.0)")

        // Check items
        if let unwrappedItems = items {
            print("Items Count: \(unwrappedItems.count)")
            for item in unwrappedItems {
                print("Item: \(item.name), Product ID: \(item.productID), Description: \(item.description), Price: \(item.price), Quantity: \(item.quantity)")
            }
        } else {
            print("Items array is nil.")
        }

        // Title
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Receipt"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(titleLabel)
        
        let feedbackButton = UIButton(type: .system)
           feedbackButton.translatesAutoresizingMaskIntoConstraints = false
           feedbackButton.setTitle("Give Feedback", for: .normal)
           feedbackButton.backgroundColor = .systemBlue
           feedbackButton.setTitleColor(.white, for: .normal)
           feedbackButton.layer.cornerRadius = 10
           feedbackButton.addTarget(self, action: #selector(feedbackButtonTapped), for: .touchUpInside)
           view.addSubview(feedbackButton)

        // Transaction ID
        // Transaction ID
        let transactionIDLabel = UILabel()
        transactionIDLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionIDLabel.text = "Transaction ID: \(transactionID ?? "Unknown")"
        transactionIDLabel.font = UIFont.systemFont(ofSize: 16)
        transactionIDLabel.numberOfLines = 0 // Allow multiple lines
        view.addSubview(transactionIDLabel)

        // Set constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            transactionIDLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            transactionIDLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            transactionIDLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            transactionIDLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300), // Set a maximum width
        ])


        // Items list with product details
        let itemsLabel = UILabel()
        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsLabel.numberOfLines = 0 // Allow multiple lines

        let formattedItems = formatItemsForDisplay(items: items ?? [])
        print(formattedItems) // Debugging output
        itemsLabel.text = formattedItems
        view.addSubview(itemsLabel)

        // Total
        let totalLabel = UILabel()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.text = "Total: $\(total ?? 0.0)"
        totalLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(totalLabel)

        // OK Button
        let okButton = UIButton(type: .system)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("OK", for: .normal)
        okButton.backgroundColor = .systemGreen
        okButton.setTitleColor(.white, for: .normal)
        okButton.layer.cornerRadius = 10
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        view.addSubview(okButton)

        // Set constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            transactionIDLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            transactionIDLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            transactionIDLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            itemsLabel.topAnchor.constraint(equalTo: transactionIDLabel.bottomAnchor, constant: 20),
            itemsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            totalLabel.topAnchor.constraint(equalTo: itemsLabel.bottomAnchor, constant: 20),
            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            okButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 30),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.widthAnchor.constraint(equalToConstant: 150),
            okButton.heightAnchor.constraint(equalToConstant: 50),
            
            feedbackButton.topAnchor.constraint(equalTo: okButton.bottomAnchor, constant: 20),
                    feedbackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    feedbackButton.widthAnchor.constraint(equalToConstant: 150),
                    feedbackButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        // Ensure transactionID and total are valid
//        guard let transactionID = transactionID, let total = total else {
//            print("Transaction ID or total is missing.")
//            return
//        }
//
//        // Title
//        let titleLabel = UILabel()
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.text = "Receipt"
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        titleLabel.accessibilityLabel = "Receipt Title"
//        view.addSubview(titleLabel)
//
//        // Transaction ID
//        let transactionIDLabel = UILabel()
//        transactionIDLabel.translatesAutoresizingMaskIntoConstraints = false
//        transactionIDLabel.text = "Transaction ID: \(transactionID)"
//        transactionIDLabel.font = UIFont.systemFont(ofSize: 16)
//        transactionIDLabel.accessibilityLabel = "Transaction ID"
//        view.addSubview(transactionIDLabel)
//
//        // Items list with product details
//        let itemsLabel = UILabel()
//        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
//        itemsLabel.numberOfLines = 0
//        itemsLabel.text = formatItemsForDisplay(items: items) // Using a helper function
//        view.addSubview(itemsLabel)
//
//        // Total
//        let totalLabel = UILabel()
//        totalLabel.translatesAutoresizingMaskIntoConstraints = false
//        totalLabel.text = "Total: $\(total)"
//        totalLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        totalLabel.accessibilityLabel = "Total Price"
//        view.addSubview(totalLabel)
//
//        // OK Button
//        let okButton = UIButton(type: .system)
//        okButton.translatesAutoresizingMaskIntoConstraints = false
//        okButton.setTitle("OK", for: .normal)
//        okButton.backgroundColor = .systemGreen
//        okButton.setTitleColor(.white, for: .normal)
//        okButton.layer.cornerRadius = 10
//        okButton.accessibilityHint = "Tap to return to the home screen"
//        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
//        view.addSubview(okButton)
//
//        // Set constraints
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
//            transactionIDLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            transactionIDLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            transactionIDLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            itemsLabel.topAnchor.constraint(equalTo: transactionIDLabel.bottomAnchor, constant: 20),
//            itemsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            itemsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            totalLabel.topAnchor.constraint(equalTo: itemsLabel.bottomAnchor, constant: 20),
//            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//
//            okButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 30),
//            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            okButton.widthAnchor.constraint(equalToConstant: 150),
//            okButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }

    @objc func okButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeVC = storyboard.instantiateViewController(withIdentifier: "UserHomeVC") as? UserHomeVC {
            print("Navigating to Home Screen")
            navigationController?.pushViewController(homeVC, animated: true)
        } else {
            print("UserHomeVC not found")
        }
    }
    
    @objc func feedbackButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Navigate to the FeedBackVC
        if let feedbackVC = storyboard.instantiateViewController(withIdentifier: "FeedBackVC") as? FeedBackVC {
           // feedbackVC.item = productss
            print("Navigating to Feedback Screen")
            navigationController?.pushViewController(feedbackVC, animated: true)
        } else {
            print("FeedBackVC not found")
        }
    }

    // Helper function to format items with product details
    func formatItemsForDisplay(items: [Item]) -> String {
        return "Items Purchased:\n" + items.map { item in
            print("Formatting item: \(item.name)") // Debugging line
            return """
            Product: \(item.name)
            Product ID: \(item.productID)
            Description: \(item.description)
            Price: $\(item.price) x \(item.quantity)
            """
        }.joined(separator: "\n\n")
    }

}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


