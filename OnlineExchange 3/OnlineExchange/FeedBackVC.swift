//
//  FeedBackVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 10/21/24.
//

import UIKit

class FeedBackVC: UIViewController, UITextViewDelegate{
    
    // Properties to hold the product details
    var product: ProductModel?
    
    var item: [Items]!

    
    struct Items {
        var name: String
        var price: Double
        var quantity: Int
        var productID: String // Adding product ID
        var description: String // Adding product description
    }
    
    
    @IBAction func starTapped(_ sender: UIButton) {
        
        let rating = sender.tag  // Get the button's tag, which represents the star number
        updateStars(rating: rating)
        
        
    }
    
    
    // Function to update the stars based on user rating
        func updateStars(rating: Int) {
            let starButtons = [star1, star2, star3, star4, star5]
            for (index, button) in starButtons.enumerated() {
                if index < rating {
                    button?.setImage(UIImage(systemName: "star.fill"), for: .normal) // Filled star for selected rating
                } else {
                    button?.setImage(UIImage(systemName: "star"), for: .normal) // Empty star for unselected rating
                }
            }
        }

        // Function to setup the placeholder for the UITextView
        func setupCommentTextView() {
            userCOMMENT.text = "Leave your feedback here..."
            userCOMMENT.textColor = UIColor.lightGray
            userCOMMENT.delegate = self
        }

        // Function to update UI with product details
        private func updateUI() {
            guard let product = product else { return }
            itemname.text = product.productname
            itemquantity.text = "Quantity: \(product.quantity)"
            itemprice.text = "Price: $\(product.bidPrice)"
            
            // Use productImageUrl directly and check if it's not empty
            if !product.productImageUrl.isEmpty, let url = URL(string: product.productImageUrl) {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "logo"))
            } else {
                imageView.image = UIImage(named: "logo") // Default image if URL is empty
            }
        }
        
        // UITextViewDelegate methods for handling the placeholder text
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "Leave your feedback here..."
                textView.textColor = UIColor.lightGray
            }
        }
    
    
    
    @IBAction func Submit(_ sender: Any) {
        
        
        guard let comment = userCOMMENT.text, comment != "Leave your feedback here..." else {
                   showAlert(title: "Feedback Missing", message: "Please enter your feedback before submitting.")
                   return
               }
               
               // Proceed with submitting feedback (add submission code here)
               
               // Show thank you alert and navigate to UserHomeVC
               let alert = UIAlertController(title: "Thank You!", message: "Your feedback has been submitted.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                   if let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as? UserHomeVC {
                       print("Navigating to Home Screen")
                       self.navigationController?.pushViewController(homeVC, animated: true)
                   } else {
                       print("UserHomeVC not found")
                   }
               }))
               present(alert, animated: true)
           }
           
           // Function to show alert
//           private func showAlert(title: String, message: String) {
//               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//               alert.addAction(UIAlertAction(title: "OK", style: .default))
//               present(alert, animated: true)
//           }
       
    
    
    private func submitFeedbackToServer(rating: Int, comment: String) {
            // Replace with your database code, e.g., Firestore:
            // let feedbackData = ["rating": rating, "comment": comment, "productID": product?.id]
            // Firestore.firestore().collection("feedbacks").addDocument(data: feedbackData)
            print("Feedback submitted with rating: \(rating) and comment: \(comment)")
        }
        
        // MARK: - Alert Helper
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    
    
    
    
    
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var itemname: UILabel!
    
    @IBOutlet weak var itemquantity: UILabel!
    
    @IBOutlet weak var itemprice: UILabel!
    
    @IBOutlet weak var star1: UIButton!
    
    
    @IBOutlet weak var star2: UIButton!
    
    @IBOutlet weak var star3: UIButton!
    
    @IBOutlet weak var star4: UIButton!
    
    
    @IBOutlet weak var star5: UIButton!
    
    
    @IBOutlet weak var userCOMMENT: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //updateUI()
        
        // Setting the tag for each star button (this can also be done in the storyboard)
        star1.tag = 1
        star2.tag = 2
        star3.tag = 3
        star4.tag = 4
        star5.tag = 5
        
        setupCommentTextView()
    }
    
    // Function to update the stars based on user rating
//    func updateStars(rating: Int) {
//        let starButtons = [star1, star2, star3, star4, star5]
//        for (index, button) in starButtons.enumerated() {
//            if index < rating {
//                button?.setImage(UIImage(systemName: "star.fill"), for: .normal) // Filled star for selected rating
//            } else {
//                button?.setImage(UIImage(systemName: "star"), for: .normal) // Empty star for unselected rating
//            }
//            
//        }
//        
//        // Function to setup the placeholder for the UITextView
//        func setupCommentTextView() {
//            userCOMMENT.text = "Leave your feedback here..."
//            userCOMMENT.textColor = UIColor.lightGray
//            userCOMMENT.delegate = self
//        }
//        
//    }
//        private func updateUI() {
//            guard let product = product else { return }
//            itemname.text = product.productname
//            itemquantity.text = "Quantity: \(product.quantity)"
//            itemprice.text = "Price: $\(product.bidPrice)"
//            
//            // Use productImageUrl directly and check if it's not empty
//            if !product.productImageUrl.isEmpty, let url = URL(string: product.productImageUrl) {
//                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "logo"))
//            } else {
//                imageView.image = UIImage(named: "logo") // Default image if URL is empty
//                
//            }
//            
//            //func updateUI() {
//            //      itemname.text = productName
//            //      itemquantity.text = productQuantity
//            //      itemprice.text = productPrice
//            //
//            //      if let imageUrl = productImage {
//            //          imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "logo"))
//            //      }
//            //  }
//            
//            // UITextViewDelegate methods for handling the placeholder text
//            extension FeedBackVC: UITextViewDelegate {
//                
//                func textViewDidBeginEditing(_ textView: UITextView) {
//                    if textView.textColor == UIColor.lightGray {
//                        textView.text = nil
//                        textView.textColor = UIColor.black
//                    }
//                }
//                
//                func textViewDidEndEditing(_ textView: UITextView) {
//                    if textView.text.isEmpty {
//                        textView.text = "Leave your feedback here..."
//                        textView.textColor = UIColor.lightGray
//                    }
//                    
//                }
//                
                
                /*
                 // MARK: - Navigation
                 
                 // In a storyboard-based application, you will often want to do a little preparation before navigation
                 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                 // Get the new view controller using segue.destination.
                 // Pass the selected object to the new view controller.
                 }
                 */
                
                
            }
        

//var body: some View {
//      VStack(alignment: .leading, spacing: 20) {
//          Text("Feedback")
//              .font(.largeTitle)
//              .fontWeight(.bold)
//          
//          Text("Let us know your thoughts!")
//              .font(.subheadline)
//              .foregroundColor(.gray)
//          
//          Text("Your feedback:")
//              .font(.headline)
//          
//          TextEditor(text: $feedbackText)
//              .frame(height: 150)
//              .padding()
//              .background(Color(UIColor.systemGray6))
//              .cornerRadius(8)
//              .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
//          
//          Text("Rate our service:")
//              .font(.headline)
//          
//          Slider(value: $rating, in: 1...5, step: 1)
//          Text("Rating: \(Int(rating))")
//          
//          Button(action: submitFeedback) {
//              Text("Submit")
//                  .font(.headline)
//                  .frame(maxWidth: .infinity)
//                  .padding()
//                  .background(Color.blue)
//                  .foregroundColor(.white)
//                  .cornerRadius(8)
//          }
//          
//          if submitted {
//              Text("Thank you for your feedback!")
//                  .foregroundColor(.green)
//                  .font(.subheadline)
//                  .padding(.top, 10)
//          }
//          
//          Spacer()
//      }
//      .padding()
//  }
//  
//  func submitFeedback() {
//      // Add code to handle submission here
//      // For example, send the feedback to a server
//      submitted = true
//  }
//}
//
//struct FeedbackView_Previews: PreviewProvider {
//  static var previews: some View {
//      FeedbackView()
//  }
//}
//    
//
