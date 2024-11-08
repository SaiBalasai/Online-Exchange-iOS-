
import UIKit
class CometChatReceiverTextMessageBubble: UITableViewCell {
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
     
    @IBOutlet weak var name: UILabel!
  
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.messageView.maskedCorners(corners: [.bottomRight , .topLeft , .topRight], radius: 12)
//        messageView.dropShadow()
//        self.messageView.backgroundColor = .white
//        self.message.textColor = .black
//    }
    
    override func awakeFromNib() {
           super.awakeFromNib()
           
           // Customize message view corners and shadow
           self.messageView.maskedCorners(corners: [.bottomRight , .topLeft , .topRight], radius: 12)
           messageView.dropShadow()
           self.messageView.backgroundColor = .white
           self.message.textColor = .black
           
//           // Add the unread indicator next to the name label
//           contentView.addSubview(unreadIndicator)
//           
//           // Set up constraints for unread indicator
//           NSLayoutConstraint.activate([
//               unreadIndicator.widthAnchor.constraint(equalToConstant: 16), // Width for unread indicator
//               unreadIndicator.heightAnchor.constraint(equalToConstant: 16), // Height for unread indicator
//               unreadIndicator.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 5), // Position next to the name label
//               unreadIndicator.centerYAnchor.constraint(equalTo: name.centerYAnchor) // Center it vertically
//           ])
       }
    
    // Unread message indicator
        let unreadIndicator: UILabel = {
            let label = UILabel()
            label.backgroundColor = .red // Customize the color if needed
            label.layer.cornerRadius = 4 // Makes it circular
            label.clipsToBounds = true
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
            label.isHidden = true // Initially hidden
            return label
        }()
   
    func setData(message: MessageModel) {
           
           // Adjust message text padding if needed
           if message.text.count < 8 {
               self.message.text = "   \(message.text)   "
           } else {
               self.message.text = message.text
           }
           
           // Set name and timestamp
           self.name.text = message.senderName
           self.timeStamp.text = message.dateSent.getTimeOnly()
           
           // Show unread indicator if message is unread
           if message.isRead {
               unreadIndicator.isHidden = true
           } else {
               unreadIndicator.isHidden = false
               unreadIndicator.text = "!" // Set a symbol or leave it empty for just an indicator
           }
       }
}
 
