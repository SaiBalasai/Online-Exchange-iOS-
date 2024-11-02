////
//
//import UIKit
//import FirebaseCore
////import BraintreeDropIn
//import BraintreeCore
//import BraintreeCard
//import BraintreeApplePay
//import BraintreePayPal
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        Thread.sleep(forTimeInterval: 3.0)
//        
//       // UserDefaults.standard.set(true, forKey: "UIViewShowAlignmentRectEdges")
//
//        
//        FirebaseApp.configure()
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//
//}
//
//import UIKit
//import FirebaseCore
//import BraintreeCore
//import BraintreeCard
//import BraintreeApplePay
//import BraintreePayPal
//import UserNotifications
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Delay for splash screen visibility (optional)
//        Thread.sleep(forTimeInterval: 3.0)
//        
//        // Configure Firebase
//        FirebaseApp.configure()
//        
//        // Initialize Braintree (if needed, depending on your payment setup)
//        setupBraintree()
//
//        // Request notification permission
//        requestNotificationPermission()
//        
//        return true
//    }
//
//    // MARK: - Braintree Setup
//    private func setupBraintree() {
//        // Set up Braintree environment if needed (e.g., Braintree client token, environment configuration).
//        // Placeholder code; modify as needed for your Braintree setup.
//        // For example: BTAppSwitch.setReturnURLScheme("com.yourapp.bundleID.payments")
//    }
//
//    // MARK: - Request Notification Permission
//    private func requestNotificationPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//            if let error = error {
//                print("Notification permission request error: \(error)")
//            } else if granted {
//                print("Notification permission granted.")
//            } else {
//                print("Notification permission denied.")
//            }
//        }
//    }
//
//    // MARK: - UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Create a new scene configuration with the default settings
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session
//        // Release any resources that were specific to the discarded scenes, as they will not return
//    }
//}
import UIKit
import FirebaseCore
import BraintreeCore
import BraintreeCard
import BraintreeApplePay
import BraintreePayPal
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Delay for splash screen visibility (optional)
        Thread.sleep(forTimeInterval: 3.0)
        
        // Configure Firebase
        FirebaseApp.configure()
        
        // Initialize Braintree (if needed, depending on your payment setup)
        setupBraintree()

        // Request notification permission and set up notification delegate
        requestNotificationPermission()
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    // MARK: - Braintree Setup
    private func setupBraintree() {
        // Set up Braintree environment if needed (e.g., Braintree client token, environment configuration).
        // Placeholder code; modify as needed for your Braintree setup.
        // For example: BTAppSwitch.setReturnURLScheme("com.yourapp.bundleID.payments")
    }

    // MARK: - Request Notification Permission
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification permission request error: \(error)")
            } else if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }

    // MARK: - UNUserNotificationCenterDelegate

    // This method is called when a notification is delivered to a foreground app
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the alert and play the sound even when the app is open
        completionHandler([.alert, .sound])
    }

    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Create a new scene configuration with the default settings
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session
        // Release any resources that were specific to the discarded scenes, as they will not return
    }
}
