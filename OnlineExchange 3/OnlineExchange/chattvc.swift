import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

class chattvc: UITableViewController {

    var messages = [
            ChatMessage(text: "Hello! How are you?", isIncoming: true, date: Date()),
            ChatMessage(text: "I'm good, thanks! How about you?", isIncoming: false, date: Date()),
            ChatMessage(text: "Doing well! Just working on a project.", isIncoming: true, date: Date())
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
            tableView.separatorStyle = .none
            tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            
            setupInputComponents()
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
            let message = messages[indexPath.row]
            cell.chatMessage = message
            return cell
        }

        // Set the height dynamically based on the message content
        override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        // Setup message input bar at the bottom
    private func setupInputComponents() {
        // Create a container view for the input components
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        // Set constraints for the container view
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Create the text field
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect // Add rounded border style
        containerView.addSubview(textField)

        // Set constraints for the text field
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -68),
            textField.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: -16)
        ])

        // Create the send button
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.backgroundColor = UIColor.systemBlue // Set background color
        sendButton.setTitleColor(.white, for: .normal) // Set text color
        sendButton.layer.cornerRadius = 5 // Add corner radius
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)

        // Set constraints for the send button
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 60)
        ])

        // Add a border around the container view
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 8
    }

    @objc func handleSend() {
        // Check for a valid message
        guard let text = (view.subviews.compactMap { $0 as? UIView }.first?.subviews.compactMap { $0 as? UITextField }.first?.text), !text.isEmpty else {
            return
        }
        
        let newMessage = ChatMessage(text: text, isIncoming: false, date: Date())
        messages.append(newMessage)
        
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        // Clear the text field after sending the message
        if let textField = view.subviews.compactMap({ $0 as? UIView }).first?.subviews.compactMap({ $0 as? UITextField }).first {
            textField.text = ""
        }
    }
}
