//
//  CloudKitPushNotification.swift
//  NanoProject4
//
//  Created by Lucas Nascimento on 08/11/23.
//

import SwiftUI
import CloudKit
import UserNotifications

class ClouKitPushNotificationViewModel: ObservableObject {
    
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
    
    func subscribeToNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            guard success else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
}

struct CloudKitPushNotification: View {

    @StateObject private var vm = ClouKitPushNotificationViewModel()
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
