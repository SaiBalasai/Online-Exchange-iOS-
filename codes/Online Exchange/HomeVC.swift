//
//  HomeVC.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 5/20/24.
//

import UIKit
struct Product {
    let name: String
    let imageName: String
}


class HomeVC: UIViewController {
    
    
    var products: [Product] = [
           Product(name: "Apple iPhone 16", imageName: "iphone16.jpg"),
           Product(name: "Samsung Galaxy S23", imageName: "Samsung s23.jpg"),
           Product(name: "Google Pixel 8", imageName: "pixel 8.jpg")
       ]
    
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
        collectionview.dataSource = self
              collectionview.delegate = self
        if let layout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.scrollDirection = .vertical // or .horizontal if you want
               }
       // itemImage.image = UIImage(named: "Apple-iPhone-16-hero-240909_inline.jpg.medium_2x")

        // Do any additional setup after loading the view.
    }
    private func setBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showBidScreen" {
                if let destinationVC = segue.destination as? BidVC, let indexPath = collectionview.indexPathsForSelectedItems?.first {
                    destinationVC.selectedProduct = products[indexPath.row]
                }
            }
        }


}
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        
        cell.itemImage.image = UIImage(named: product.imageName)
        cell.itemName.text = product.name
        
        return cell
    }
    
    // Set the size for the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    // Navigate to the bid screen when a product is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBidScreen", sender: self)
    }
}
