

import UIKit
import SDWebImage

class BidProductVC: BaseViewController, UITextFieldDelegate {
    @IBOutlet weak var detailTxt: UITextView!
    @IBOutlet weak var productNameTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var quantityTxt: UITextField!
    @IBOutlet weak var productimage: UIImageView!
    
    var productData: ProductModel?
    var totalProduct = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.showProductData()
        
        quantityTxt.delegate = self
        quantityTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }

    
    func showProductData(){
        self.productNameTxt.text = productData?.productname
        self.priceTxt.text = productData?.price
        self.detailTxt.text = productData?.productDetail
        
        let imageUrl = productData?.productImageUrl ?? ""

        self.productimage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "logo"))
        
        totalProduct = Int(productData?.availableQuantity ?? "0") ?? 0

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
            guard let text = textField.text, let enteredQuantity = Int(text) else {
                return
            }

            if enteredQuantity <= totalProduct {
                self.quantityTxt.text = "\(enteredQuantity)"
            } else {
                showAlerOnTop(message: "Exceed Quantity limit")
            }
        }

    @IBAction func btnAddBid(_ sender: UIButton) {
        if(quantityTxt.text!.isEmpty) {
            showAlerOnTop(message: "Please enter quantity")
            return
        } else {
            let data = ProductModel(productname: self.productData?.productname ?? "", adminId: self.productData?.adminId ?? "", price: self.productData?.price ?? "", quantity: self.quantityTxt.text ?? "", productImageUrl: self.productData?.productImageUrl ?? "", userId: UserDefaultsManager.shared.getDocumentId(), availableQuantity: self.productData?.availableQuantity ?? "", productDetail: self.productData?.productDetail ?? "")
            
            FireStoreManager.shared.productRequestToAdmin(documentID: UserDefaultsManager.shared.getDocumentId(), adminId: self.productData?.adminId ?? "", product: data) { success in
                if success {
                    showAlerOnTop(message: "Place bid successfully. Request send to admin")
                    self.navigationController?.popToRootViewController(animated: true)
                } else {
                    showAlerOnTop(message: "You already placed bid for this item.")
                }
            }
        }
    }
}
