import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    // Track notified message IDs
    private let notifiedMessagesKey = "notifiedMessages"
    
    // Get list of notified message IDs from UserDefaults
    private func getNotifiedMessages() -> Set<String> {
        return Set(UserDefaults.standard.stringArray(forKey: notifiedMessagesKey) ?? [])
    }
    
    // Save notified message ID to UserDefaults
    private func addNotifiedMessage(id: String) {
        var notifiedMessages = getNotifiedMessages()
        notifiedMessages.insert(id)
        UserDefaults.standard.set(Array(notifiedMessages), forKey: notifiedMessagesKey)
    }
    
    // Check if the message has already been notified
    func isMessageNotified(id: String) -> Bool {
        return getNotifiedMessages().contains(id)
    }
    
    // Send notification (you can customize this method for your notification logic)
    func sendNotification(for messageID: String, content: String) {
        // Add notification logic here (e.g., local notification)
        addNotifiedMessage(id: messageID)
        
        // Example of a simple local notification
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "New Message"
        notificationContent.body = content
        
        let request = UNNotificationRequest(identifier: messageID, content: notificationContent, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
