
import UIKit
import SDWebImage

enum userValue {
    case manager
}

class ProductListVC: BaseViewController ,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var products: [ProductModel] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        FireStoreManager.shared.getAdminProducts { [weak self] productsArray, error in
            guard let self = self else { return }
            if let productsArray = productsArray {
                self.products = productsArray
                self.tableView.reloadData()
            }
        }
    }


    
}


extension ProductListVC {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
        let data = self.products[indexPath.row]
        cell.productName.text = "Product Name: \(data.productname)"
        cell.quantity.text = "Quantity: \(data.quantity)"
        cell.price.text = "Price: \(data.price)"
        cell.productDetail.text = "Detail: \(data.productDetail)"
        
        
        
        let imageUrl = data.productImageUrl

        cell.productImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "logo"))
        
        
        cell.acceptBtn.isHidden = true
        
        if data.adminEmail != UserDefaultsManager.shared.getEmail() {
            cell.acceptBtn.isHidden = false
        }
        
        cell.acceptBtn.tag = indexPath.row
        cell.acceptBtn.addTarget(self, action: #selector(openRaiseRequest(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    @objc func openRaiseRequest(_ sender: UIButton) {
        let data = self.products[sender.tag]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  "BidProductVC" ) as! BidProductVC
        vc.productData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
}

