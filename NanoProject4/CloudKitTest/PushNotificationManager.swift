//
//  PushNotificationManager.swift
//  NanoProject4
//
//  Created by Lucas Nascimento on 08/11/23.
//

import SwiftUI
import UserNotifications

class PushNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {

    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func requestNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print(error)
            } else if granted {
                print("Notification permissions granted!")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Notification permissions denied.")
            }
        }
    }

    func applicationDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token:", token)
    }

    func applicationDidFailToRegisterForRemoteNotificationsWithError(error: Error) {
        print("Failed to register for remote notifications:", error)
    }

}
