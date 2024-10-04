//
//  ChatViewController.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 9/30/24.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messages = [
        ChatMessage(text: "Hello! How are you?", isIncoming: true, date: Date()),
        ChatMessage(text: "I'm good, thanks! How about you?", isIncoming: false, date: Date()),
        ChatMessage(text: "Doing well! Just working on a project.", isIncoming: true, date: Date())
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set delegate and data source for the table view
            tableView.delegate = self
            tableView.dataSource = self
            
            // Register the chat message cell
            tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
        }
        
        // MARK: - UITableViewDataSource
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
            let message = messages[indexPath.row]
            cell.chatMessage = message
            return cell
        }

        // MARK: - UITableViewDelegate
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Deselect the row
            tableView.deselectRow(at: indexPath, animated: true)
            
            // Perform the segue to MessageDetailViewController
            performSegue(withIdentifier: "showMessageDetail", sender: messages[indexPath.row])
        }
        
        // Prepare for the segue to MessageDetailViewController
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showMessageDetail" {
                if let destinationVC = segue.destination as? MessageDetailViewController,
                   let selectedMessage = sender as? ChatMessage {
                    destinationVC.chatMessage = selectedMessage
                }
            }
        }

        @IBAction func handleSend(_ sender: UIButton) {
            // Check for a valid message
            guard let text = messageTextField.text, !text.isEmpty else {
                return
            }
            
            let newMessage = ChatMessage(text: text, isIncoming: false, date: Date())
            messages.append(newMessage)
            
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            
            // Clear the text field after sending the message
            messageTextField.text = ""
        }
    }
