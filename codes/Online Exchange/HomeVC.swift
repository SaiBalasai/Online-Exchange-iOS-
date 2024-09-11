//
//  HomeVC.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 5/20/24.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
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


}
