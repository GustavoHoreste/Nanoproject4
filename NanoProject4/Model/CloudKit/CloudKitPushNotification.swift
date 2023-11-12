//
//  CloudKitPushNotification.swift
//  NanoProject4
//
//  Created by Lucas Nascimento on 08/11/23.
//

import SwiftUI
import CloudKit
import UserNotifications

class CloudKitPushNotificationViewModel: ObservableObject {
    static let shared = CloudKitPushNotificationViewModel()
    func requestNotificationPermissions(){
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error{
                print(error)
            }else if success{
                print("Notification permmissions success!")
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }else{
                print("Notification permmission failure.")

            }
        }
        
    }
    
    func sendPushNotification(restaurantName: String) {
            let content = UNMutableNotificationContent()
            content.title = "Novo Restaurante Adicionado"
            content.body = "O restaurante \(restaurantName) foi adicionado."

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error sending push notification: \(error)")
                } else {
                    print("Push notification sent successfully")
                }
            }
        }
    
    func subscribeToNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            guard success else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                let predicate = NSPredicate(value: true)
                
                let subscription = CKQuerySubscription(recordType: IdentifierKeys.recordType.rawValue, predicate: predicate, subscriptionID: "Restaurante_Adicionado", options: .firesOnRecordCreation)
                
                let notification = CKSubscription.NotificationInfo()
                notification.title = "There's a new notification"
                notification.alertBody = "Check this new restourant"
                notification.soundName = "default"
                
                subscription.notificationInfo = notification
                
                CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
                    if let error = returnedError {
                        print(error)
                    } else {
                        print("Succesfully Subscribed to Notifications")
                    }
                }
            }
        }
    }
}
    
    struct CloudKitPushNotification: View {
        
        @StateObject private var vm = CloudKitPushNotificationViewModel()
        @StateObject private var pushNotificationManager = PushNotificationManager()
        
        var body: some View {
            VStack(spacing: 40) {
                Button("Request notification permissions") {
                    vm.requestNotificationPermissions()
                }
                
                Button("Subscribe to notifications") {
                    vm.subscribeToNotifications()
                }
                
                Button("Solicitar Permissões de Notificação") {
                    pushNotificationManager.requestNotificationPermissions()
                }
            }
        }
    }

#Preview {
    CloudKitPushNotification()
}
