import UIKit

class ChatMessageCell: UITableViewCell {

    var chatMessage: ChatMessage! {
            didSet {
                messageLabel.text = chatMessage.text
                messageLabel.textColor = chatMessage.isIncoming ? .black : .white
                backgroundView?.backgroundColor = chatMessage.isIncoming ? UIColor(white: 0.9, alpha: 1) : UIColor.systemBlue
            }
        }
        
        private let messageLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            addSubview(messageLabel)
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
            
            // Set cell properties
            self.layer.cornerRadius = 12
            self.clipsToBounds = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        
    }
}
