//

import UIKit
import FirebaseCore
import UserNotifications
import FirebaseMessaging



@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Request permission to send notifications when the app launches
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        registerForPushNotifications() // Register for notifications
        // UNUserNotificationCenter.current().delegate = self
        return true
    }

    // Register for local notifications
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    // This method is called when the device successfully registers for remote notifications.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Device Token: \(deviceToken)")
        // You can use this token to send notifications from your server
        Messaging.messaging().apnsToken = deviceToken
    }

    // This method is called if registration for remote notifications fails.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
