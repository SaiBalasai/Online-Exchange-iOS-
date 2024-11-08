import UIKit
import Foundation
import FirebaseFirestore
import UserNotifications


class ChatVC: UIViewController {

    @IBOutlet weak var chatContainer: UIView!
    let id = getEmail()
    @IBOutlet weak var textView: TextViewWithPlaceholder!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnOptions: UIButton!
    @IBOutlet weak var addImages: UIButton!
    @IBOutlet weak var btnViewProfile: UIButton!
    @IBOutlet weak var sendMessageView: UIView!
    var chatID = ""
        var messages = [MessageModel]()
        var senderId = getEmail()
        var senderName = UserDefaultsManager.shared.getFullname()
        
        private let chatService = ChatService()
        private var chats: [Chat] = []
        
        func shortMessages() {
            messages = messages.sorted(by: {
                $0.getDate().compare($1.getDate()) == .orderedAscending
            })
        }
        
        var lastMessageTimestamp: Double = 0 // Track the last message timestamp

//        func getMessages() {
//            FireStoreManager.shared.getLatestMessages(chatID: chatID) { (documents, error) in
//                if let error = error {
//                    print("Error retrieving messages: \(error)")
//                } else if let documents = documents {
//                    var messages = [MessageModel]()
//                    
//                    for document in documents {
//                        let data = document.data()
//                        let message = MessageModel(data: data)
//                        messages.append(message)
//                        
//                        // Check if this is a new message from another user
//                        if message.sender != self.senderId && message.dateSent > self.lastMessageTimestamp {
//                            self.lastMessageTimestamp = message.dateSent
//                            self.sendNotification(for: message)
//                        }
//                    }
//                    
//                    self.messages = messages
//                    self.shortMessages()
//                    self.reloadData()
//                }
//            }
//        }
    
    func getMessages() {
        FireStoreManager.shared.getLatestMessages(chatID: chatID) { (documents, error) in
            if let error = error {
                print("Error retrieving messages: \(error)")
            } else if let documents = documents {
                var messages = [MessageModel]()
                let currentUserEmail = self.senderId
                
                for document in documents {
                    let data = document.data()
                    let message = MessageModel(data: data)
                    messages.append(message)
                    
                    // Trigger notification only if recipient matches current user
                    if message.sender != currentUserEmail && message.recipient == currentUserEmail && message.dateSent > self.lastMessageTimestamp {
                        self.lastMessageTimestamp = message.dateSent
                        self.sendNotification(for: message)
                    }
                }
                
                self.messages = messages
                self.shortMessages()
                self.reloadData()
            }
        }
    }


        func sendNotification(for message: MessageModel) {
            let content = UNMutableNotificationContent()
            content.title = "New message from \(message.senderName)"
            content.body = message.text
            content.sound = .default

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Failed to add notification request: \(error)")
                }
            }
        }
    
//    
//    func getMessages() {
//       FireStoreManager.shared.getLatestMessages(chatID: chatID) { (documents, error) in
//            if let error = error {
//                // Handle the error
//                print("Error retrieving messages: \(error)")
//            } else if let documents = documents {
//                // Create an array to store MessageModel instances
//                var messages = [MessageModel]()
//                
//                for document in documents {
//                    let data = document.data()
//                    
//                    // Create a MessageModel instance from Firestore data
//                    let message = MessageModel(data: data)
//                    
//                    // Append the message to the array
//                    messages.append(message)
//                }
//                
//                self.messages = messages
//                self.shortMessages()
//                self.reloadData()
//                
//            }
//        }
//    }


 
  

}

extension ChatVC {
 
    @IBAction func onSend(_ sender: Any) {
        
        
        guard let text = textView.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
                    showAlerOnTop(message: "Please enter text")
                    return
                }
                
                textView.text = ""
                sendTextMessage(text: text, recipientEmail: "")
        
//        if(self.textView.text.isEmpty) {
//          
//           showAlerOnTop(message: "Please enter Text")
//        }
//        guard let text = self.textView.text else {
//            return
//        }
//
//        let msgText = text.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard !msgText.isEmpty else {
//            return
//        }
// 
//        self.textView.text = ""
//        
//        self.sendTextMessage(text:msgText)

    }
    
    func getTime()-> Double {
        return Double(Date().millisecondsSince1970)
    }
    
//    func sendTextMessage(text: String) {
//        self.view.endEditing(true)
//        
//     
//        FireStoreManager.shared.saveChat(userEmail: getEmail().lowercased(), text:text, time: getTime(), chatID: chatID)
//        
//      
//       // self.getMessages()
//       // self.tableView.reloadData()
// 
//    }
    
    func sendTextMessage(text: String, recipientEmail: String) {
        FireStoreManager.shared.saveChat(
            userEmail: senderId.lowercased(),
            recipientEmail: recipientEmail,
            text: text,
            time: Double(Date().millisecondsSince1970),
            chatID: chatID
        )
    }

    
}


 
extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    


    
    
        


//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//        let message = messages[indexPath.row]
//        if message.sender ==  senderId {
//            let cell = self.tableView.dequeueReusableCell(withIdentifier: "CometChatSenderTextMessageBubble") as! CometChatSenderTextMessageBubble
//            cell.setData(message: message)
//            return cell
//            
//        } else {
//            let cell = self.tableView.dequeueReusableCell(withIdentifier: "CometChatReceiverTextMessageBubble") as! CometChatReceiverTextMessageBubble
//            cell.setData(message: message)
//            return cell
//           
//        }
//    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        if message.sender == senderId {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CometChatSenderTextMessageBubble") as! CometChatSenderTextMessageBubble
            cell.setData(message: message)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CometChatReceiverTextMessageBubble") as! CometChatReceiverTextMessageBubble
            cell.setData(message: message)
            
            // Display an indicator for unread messages
            cell.unreadIndicator.isHidden = message.isRead
            return cell
        }
    }

 
   
}
 


import UIKit
extension ChatVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.size.width - 10)
        self.chatContainer.dropShadow()
        
        fetchChats()
       
        self.setTableView()
        self.setNameAndTitle()
        self.getMessages()
        
        let userType = UserDefaultsManager.shared.getUserType()
        if userType == UserType.admin.rawValue{
            self.chatContainer.isHidden = true
        } else {
            self.chatContainer.isHidden = false
        }
    }
    
    private func fetchChats() {
           chatService.fetchChats { [weak self] chats in
               self?.chats = chats
               DispatchQueue.main.async {
                   self?.tableView.reloadData()
               }
           }
       }
    
    
   


    
    func setNameAndTitle() {
        self.navigationController?.title = "Chat"
    }
    
    func setTableView() {
        self.registerCells()

        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        markMessagesAsRead()
    }
    
    func markMessagesAsRead() {
        let chatDbRef = Firestore.firestore().collection("Chat")
        let messagesCollection = chatDbRef.document(chatID).collection("Messages")
        
        messagesCollection.whereField("isRead", isEqualTo: false).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error updating messages: \(error)")
                return
            }
            
            querySnapshot?.documents.forEach { document in
                document.reference.updateData(["isRead": true])
            }
        }
    }

    
   
    
    func registerCells() {
        self.tableView.register(UINib(nibName: "CometChatSenderTextMessageBubble", bundle: nil), forCellReuseIdentifier: "CometChatSenderTextMessageBubble")
        self.tableView.register(UINib(nibName: "CometChatReceiverTextMessageBubble", bundle: nil), forCellReuseIdentifier: "CometChatReceiverTextMessageBubble")
       
    }
    
    func reloadData(){
        self.tableView.reloadData()
        self.tableView.scroll(to: .bottom, animated: true)
        self.updateTableContentInset()
    }
     
    
    //Add this function below
    func updateTableContentInset() {
        let numRows = self.tableView.numberOfRows(inSection: 0)
        var contentInsetTop = self.tableView.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.tableView.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
                break
            }
        }
 
    }
}


func getChatID(email1: String, email2: String) -> String {
    let comparisonResult = email1.compare(email2)
    if comparisonResult == .orderedAscending {
        return email1 + email2
    } else {
        return email2 + email1
    }
}






struct MessageModel {
    var sender: String
    var recipient: String
    var dateSent: Double
    var chatId: String
    var text: String
    var senderName: String
    var isRead: Bool // New property for read status
    var unreadCount: Int // Add this line
    //var isUnread: Bool

    init(data: [String: Any]) {
            self.sender = data["sender"] as? String ?? ""
            self.recipient = data["recipient"] as? String ?? "" // Initialize recipient
            self.dateSent = data["dateSent"] as? Double ?? 0.0
            self.chatId = data["chatId"] as? String ?? ""
            self.text = data["text"] as? String ?? ""
            self.senderName = data["senderName"] as? String ?? ""
            self.isRead = data["isRead"] as? Bool ?? false
            self.unreadCount = data["unreadCount"] as? Int ?? 0
        
        }
    
    
   
    func getDate() -> Date {
        Date(timeIntervalSince1970: dateSent)
    }

    func getDataString() -> String {
        let date = Date(timeIntervalSince1970: dateSent)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}





extension FireStoreManager {
    
   
    
//      func saveChat(userEmail:String, text:String,time:Double,chatID:String){
//          
//         let chatDbRef = self.db.collection("Chat")
//         let lastMessages = self.db.collection("LastMessages")
//          
//          let sender = UserDefaultsManager.shared.getEmail()
//          let senderName = UserDefaultsManager.shared.getFullname()
//          
//          let data = ["senderName" : senderName,"sender": sender,"messageType":1,"dateSent":time,"chatId":chatID,"text" : text] as [String : Any]
//          
//          let messagesCollection = chatDbRef.document(chatID).collection("Messages")
//          messagesCollection.addDocument(data: data)
//          
//          lastMessages.document(chatID).setData(data)
//          
//      }
      
//    
//    func saveChat(userEmail: String, text: String, time: Double, chatID: String) {
//        let chatDbRef = self.db.collection("Chat")
//        let lastMessages = self.db.collection("LastMessages")
//        
//        let sender = UserDefaultsManager.shared.getEmail()
//        let senderName = UserDefaultsManager.shared.getFullname()
//        
//        let data = [
//            "senderName": senderName,
//            "sender": sender,
//            "messageType": 1,
//            "dateSent": time,
//            "chatId": chatID,
//            "text": text,
//            "isRead": false // Set isRead to false for new messages
//        ] as [String: Any]
//        
//        let messagesCollection = chatDbRef.document(chatID).collection("Messages")
//        messagesCollection.addDocument(data: data)
//        
//        lastMessages.document(chatID).setData(data)
//    }

    func saveChat(userEmail: String, recipientEmail: String, text: String, time: Double, chatID: String) {
        let chatDbRef = self.db.collection("Chat")
        let lastMessages = self.db.collection("LastMessages")
        
        let sender = UserDefaultsManager.shared.getEmail()
        let senderName = UserDefaultsManager.shared.getFullname()
        
        let data = [
            "senderName": senderName,
            "sender": sender,
            "recipient": recipientEmail, // Set recipient email
            "messageType": 1,
            "dateSent": time,
            "chatId": chatID,
            "text": text,
            "isRead": false
        ] as [String: Any]
        
        let messagesCollection = chatDbRef.document(chatID).collection("Messages")
        messagesCollection.addDocument(data: data)
        
        lastMessages.document(chatID).setData(data)
    }

    
      func getLatestMessages(chatID: String, completionHandler: @escaping ([QueryDocumentSnapshot]?, Error?) -> Void) {
          let chatDbRef = self.db.collection("Chat")
          let messagesCollection = chatDbRef.document(chatID).collection("Messages")
          
          // Query the last 1000 messages
          let query = messagesCollection.order(by: "dateSent", descending: true).limit(to: 1000)
          
          // Add a snapshot listener to the query
          query.addSnapshotListener { (querySnapshot, error) in
              if let error = error {
                  print("Error fetching documents: \(error)")
                  completionHandler(nil, error)
                  return
              }
              
              // Handle the snapshot data
              let documents = querySnapshot?.documents
              completionHandler(documents, nil)
          }
      }
      
      func getChatList(completionHandler: @escaping ([QueryDocumentSnapshot]?, Error?) -> Void) {
          let lastMessages = self.db.collection("LastMessages")
          let query = lastMessages.order(by: "dateSent", descending: true).limit(to: 1000)
          
          // Add a snapshot listener to the query
          query.addSnapshotListener { (querySnapshot, error) in
              if let error = error {
                  print("Error fetching documents: \(error)")
                  completionHandler(nil, error)
                  return
              }
              
              // Handle the snapshot data
              let documents = querySnapshot?.documents
              completionHandler(documents, nil)
          }
      }
    
    
}


 
extension Double{
    func getTimeOnly() ->String {
        
        let date = Date(milliseconds : Int64(self))
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d HH:mm"
            return "\(dateFormatter.string(from: date))"
    }
}



extension UITableView {
    
    
    enum Position {
      case top
      case bottom
    }
    
    func scroll(to: Position, animated: Bool) {
        let sections = numberOfSections
        let rows = numberOfRows(inSection: numberOfSections - 1)
        switch to {
        case .top:
            if rows > 0 {
                let indexPath = IndexPath(row: 0, section: 0)
                self.scrollToRow(at: indexPath, at: .top, animated: animated)
            }
            break
        case .bottom:
            if rows > 0 {
                let indexPath = IndexPath(row: rows - 1, section: sections - 1)
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
            break
        }
    }
}



extension UIView {
    func maskedCorners(corners: UIRectCorner, radius: CGFloat) {
           
                self.clipsToBounds = true
                self.layer.cornerRadius = radius
                var masked = CACornerMask()
                if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
                if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
                if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
                if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
                self.layer.maskedCorners = masked
            }
    
    func dropShadow(scale: Bool = true , height:Int = 3 , shadowRadius:CGFloat = 3) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: -1, height: height)
        layer.shadowRadius = shadowRadius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
             
}


func getEmail()->String {
    return  UserDefaultsManager.shared.getEmail()
}


extension ChatVC {
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
