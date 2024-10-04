import UIKit

class MessageDetailViewController: UIViewController {

    // Property to hold the selected chat message
    var chatMessage: ChatMessage?

    // UI Elements
    private let messageLabel = UILabel()
    private let replyTextField = UITextField()
    private let sendButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureView()
        setupBackButton()  // Add this line
    }

    private func setupBackButton() {
        // Create a custom back button
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Set the back button frame or use constraints
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        // Set constraints for the back button
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    @objc private func backButtonTapped() {
        // Pop the current view controller
        navigationController?.popViewController(animated: true)
    }

    private func setupUI() {
        // Set the background color
        view.backgroundColor = .white
        
        // Configure the message label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        view.addSubview(messageLabel)

        // Configure the reply text field
        replyTextField.translatesAutoresizingMaskIntoConstraints = false
        replyTextField.borderStyle = .roundedRect
        replyTextField.placeholder = "Type your reply..."
        view.addSubview(replyTextField)

        // Configure the send button
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(sendReply), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendButton)

        // Set constraints
        NSLayoutConstraint.activate([
            // Message label constraints
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Reply text field constraints
            replyTextField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            replyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            replyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Send button constraints
            sendButton.topAnchor.constraint(equalTo: replyTextField.bottomAnchor, constant: 10),
            sendButton.trailingAnchor.constraint(equalTo: replyTextField.trailingAnchor),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func configureView() {
        // Display the chat message in the message label
        if let message = chatMessage {
            messageLabel.text = message.text
        }
    }

    @objc private func sendReply() {
        guard let replyText = replyTextField.text, !replyText.isEmpty else {
            return // Do nothing if the text field is empty
        }
        
        // Create a new message with the reply
        let newMessage = ChatMessage(text: replyText, isIncoming: false, date: Date())
        
        // Here, you can handle the sending of the new message
        // For example, you might want to send this message back to the chat view controller or save it to a server
        print("Reply sent: \(newMessage.text)")
        
        // Clear the reply text field after sending the message
        replyTextField.text = ""
        
        // Optionally, you can dismiss this view controller or pop it
        navigationController?.popViewController(animated: true)
    }
}
