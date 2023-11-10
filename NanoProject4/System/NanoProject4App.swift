//
//  NanoProject4App.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 06/11/23.
//

import SwiftUI

@main
struct NanoProject4App: App {
    @StateObject var viewModel = RestaurantViewModel()
    
    var body: some Scene {
        WindowGroup {
//            CloudKitPushNotification()
            
            RestaurantView()
                .environmentObject(viewModel)
        }
    }
}
