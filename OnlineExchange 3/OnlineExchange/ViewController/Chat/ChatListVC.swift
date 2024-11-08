
import UIKit

class ChatListVC: BaseViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    var messages = [MessageModel]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set the data source for the tableView
            tableView.dataSource = self
            tableView.delegate = self
            self.tableView.showsVerticalScrollIndicator = false
            tableView.register(UINib(nibName: "ChatList", bundle: nil), forCellReuseIdentifier: "ChatList")
            
            let userType = UserDefaultsManager.shared.getUserType()
            if userType == UserType.admin.rawValue {
                getmessageForAdmin()
            } else {
                getMessages()
            }
        }
        
        // Sort messages by date
        func shortMessages() {
            messages = messages.sorted(by: {
                $0.getDate().compare($1.getDate()) == .orderedDescending
            })
        }
    
    
    
        
        // Fetch messages for regular users
        func getMessages() {
            FireStoreManager.shared.getChatList(userEmail: UserDefaultsManager.shared.getEmail()) { (documents, error) in
                if let error = error {
                    print("Error retrieving messages: \(error)")
                } else if let documents = documents {
                    var messages = [MessageModel]()
                    
                    for document in documents {
                        let data = document.data()
                        let message = MessageModel(data: data)
                        messages.append(message)
                    }
                    
                    self.messages = messages
                    self.shortMessages()
                    self.tableView.reloadData()
                }
            }
        }
        
        // Fetch messages for admins
        func getmessageForAdmin() {
            FireStoreManager.shared.getChatList() { (documents, error) in
                if let error = error {
                    print("Error retrieving messages: \(error)")
                } else if let documents = documents {
                    var messages = [MessageModel]()
                    
                    for document in documents {
                        let data = document.data()
                        let message = MessageModel(data: data)
                        messages.append(message)
                    }
                    
                    self.messages = messages
                    self.shortMessages()
                    self.tableView.reloadData()
                }
            }
        }
        
        // TableView data source methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatList", for: indexPath) as! ChatList
            cell.setData(message: self.messages[indexPath.row])
            return cell
        }
        
        // TableView delegate method for row selection
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let message = self.messages[indexPath.row]
            
            // Mark the message as read
            openMessage(at: indexPath)
            
            // Navigate to the chat view controller
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
            vc.chatID = message.chatId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // Mark the selected message as read and reload the table cell
        func openMessage(at indexPath: IndexPath) {
            // Access the message at the given index path
            var message = messages[indexPath.row]
            
            // Mark the message as read
            message.isRead = true
            
            // Update the message in the array
            messages[indexPath.row] = message
            
            // Reload the specific row to update the UI
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
//----------------------------------------------------------
//
//    var messages = [MessageModel]()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Set the data source for the tableView
//        tableView.dataSource = self
//        tableView.delegate = self
//        self.tableView.showsVerticalScrollIndicator = false
//        tableView.register(UINib(nibName: "ChatList", bundle: nil), forCellReuseIdentifier: "ChatList")
//        
//        let userType = UserDefaultsManager.shared.getUserType()
//        if userType == UserType.admin.rawValue{
//            getmessageForAdmin()
//        } else {
//            getMessages()
//        }
//    }
//    
//    
//    func shortMessages() {
//        messages = messages.sorted(by: {
//            $0.getDate().compare($1.getDate()) == .orderedDescending
//        })
//    }
//    
//    func getMessages() {
//        
//        FireStoreManager.shared.getChatList(userEmail: UserDefaultsManager.shared.getEmail()) { (documents, error) in
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
//                    let message = MessageModel(data: data)
//                    
//                    messages.append(message)
//                }
//                
//                self.messages = messages
//                self.shortMessages()
//                self.tableView.reloadData()
//                
//            }
//        }
//    }
//    func getmessageForAdmin() {
//        
//        FireStoreManager.shared.getChatList() { (documents, error) in
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
//                self.tableView.reloadData()
//                
//            }
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatList", for: indexPath) as! ChatList
//        cell.setData(message:self.messages[indexPath.row])
//        return cell
//    }
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let message = self.messages[indexPath.row]
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
//        vc.chatID = message.chatId
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//}
