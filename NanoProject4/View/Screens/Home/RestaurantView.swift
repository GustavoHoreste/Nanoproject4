//
//  RestaurantView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import SwiftUI

struct RestaurantView: View {
    @StateObject var viewModel = RestaurantViewModel.shared
    @StateObject var cloudKitManager = CloudKitManager.shared
    
    var body: some View {
        NavigationStack{
            RestaurantListView(restuarants: cloudKitManager.restaurants)
                .navigationTitle("Restaurantes")
                .sheet(isPresented: $viewModel.isOpenSheet, content: {
                    SheetNewRest()
                })
                .toolbar {
                    toolbarButton
                }
        }.onAppear{
            cloudKitManager.fetchRequest()
            CloudKitPushNotificationViewModel.shared.requestNotificationPermissions()
            CloudKitPushNotificationViewModel.shared.subscribeToNotifications()
        }
        .refreshable {
            cloudKitManager.fetchRequest()
            
        }
    }
    
    private var toolbarButton: some View{
        Button(action: {
            viewModel.togleSheetAddRest()
            
        }, label: {
            Image(systemName: "plus")
                .tint(.gray)

        }).buttonStyle(.borderedProminent)
    }
}

#Preview {
    RestaurantView()
}
