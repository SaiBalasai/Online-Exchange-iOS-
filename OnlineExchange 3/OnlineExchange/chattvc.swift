import UIKit

struct chatMessage {
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
    
    var messageTextField: UITextField? // Keep reference to the text field
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
        
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

    // Setup message input bar at the center of the screen
    private func setupInputComponents() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // Set constraints for the container view to stick to left, right, and bottom of the view
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),  // Stick to left
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor), // Stick to right
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), // Stick to bottom
            containerView.heightAnchor.constraint(equalToConstant: 60) // Fixed height for the container view
        ])
        
        // Create the text field and store it in the property
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        containerView.addSubview(textField)
        messageTextField = textField  // Store reference
        
        // Set constraints for the text field to fill the left space
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),  // Left padding of 8
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor), // Align vertically
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -68),  // Leave space for the send button
            textField.heightAnchor.constraint(equalToConstant: 40)  // Fixed height for the text field
        ])
        
        // Create the send button
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.backgroundColor = UIColor.systemBlue
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.layer.cornerRadius = 5
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        
        // Set constraints for the send button to fill the right space
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8), // Right padding of 8
            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),  // Align vertically
            sendButton.widthAnchor.constraint(equalToConstant: 60),  // Fixed width for the button
            sendButton.heightAnchor.constraint(equalToConstant: 40)  // Same height as the text field
        ])
        
        // Add a border around the container view
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 8
    }

    @objc func handleSend() {
        // Check for a valid message
        guard let text = messageTextField?.text, !text.isEmpty else {
            return
        }
        
        let newMessage = ChatMessage(text: text, isIncoming: false, date: Date())
        messages.append(newMessage)
        
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        // Clear the text field after sending the message
        messageTextField?.text = ""
    }
}
