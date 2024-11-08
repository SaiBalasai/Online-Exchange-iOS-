 
import UIKit

class ChatList: UITableViewCell {
    
    // @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var circle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        container.dropShadow(shadowRadius: 10)
        
        // Initial styling for the unread indicator
        circle.layer.cornerRadius = circle.frame.size.width / 2
        circle.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset the indicator visibility and color when the cell is reused
        circle.isHidden = true
        circle.backgroundColor = .clear
    }
    
   
    
//    func setData(message: MessageModel) {
//        self.email.text = "Email - \(message.sender)"
//        self.time.text = message.dateSent.getTimeOnly()
//        self.message.text = message.text
//        
////        // Display the green indicator only if the message is unread
////        if message.isRead {
////            circle.isHidden = true // Hide the indicator for read messages
////            circle.backgroundColor = .clear // Reset color for read messages
////        } else {
////            circle.isHidden = false // Show the indicator for unread messages
////            circle.backgroundColor = .green // Set green color for unread message
////        }
//        
//        if message.isRead {
//            circle.isHidden = true // Hide the indicator for read messages
//            circle.backgroundColor = .clear // Reset color for read messages
//        } else {
//            circle.isHidden = false // Show the indicator for unread messages
//            circle.backgroundColor = .green // Set green color for unread messages
//        }
//
//        
//        self.layoutIfNeeded()
//    }
    func setData(message: MessageModel) {
        self.email.text = "Email - \(message.sender)"
        self.time.text = message.dateSent.getTimeOnly()
        self.message.text = message.text
        
        // Use the user's specific read status
        if message.isReadByCurrentUser {
            circle.isHidden = true // Hide the indicator for read messages
            circle.backgroundColor = .clear
        } else {
            circle.isHidden = false // Show the indicator for unread messages
            circle.backgroundColor = .green // Set green color for unread messages
        }
        
        self.layoutIfNeeded()
    }

    
    
}
//    
//    override func awakeFromNib() {
//            super.awakeFromNib()
//            
//            container.dropShadow(shadowRadius: 10)
//            
//            // Initial styling for the unread indicator
//            circle.layer.cornerRadius = circle.frame.size.width / 2
//            circle.clipsToBounds = true
//            circle.backgroundColor = .clear // Default is clear (no indicator)
//        }
//
//        override func prepareForReuse() {
//            super.prepareForReuse()
//            circle.backgroundColor = .clear // Reset the indicator when the cell is reused
//        }
//
//        func setData(message: MessageModel) {
//            print(message)
//            self.email.text = "Email - \(message.sender)"
//            self.time.text = message.dateSent.getTimeOnly()
//            self.message.text = message.text
//
//            // Display the green indicator if the message is unread
//            if message.isRead {
//                circle.backgroundColor = .clear
//            } else {
//                circle.backgroundColor = .green // Set green color for unread message
//            }
//
//            // Force layout update if necessary
//            self.layoutIfNeeded()
//        }
//    }
