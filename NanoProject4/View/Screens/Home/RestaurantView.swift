//
//  RestaurantView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import SwiftUI

struct RestaurantView: View {
    @StateObject var viewModel = RestaurantViewModel()
    @StateObject var cloudKitManager = CloudKitManager.shared

    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                RestaurantListView(restuarants: cloudKitManager.restaurantItens)
                    .navigationTitle("Restaurantes")
                    .sheet(isPresented: $viewModel.isOpenSheet, content: {
                        SheetNewRest()
                    })
            }.toolbar{
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
}

extension RestaurantView{
    private var toolbarButton: some View{
        Button{
            viewModel.togleSheetAddRest()
        } label: {
             Image(systemName: "plus")
            
        }.buttonStyle(.borderedProminent)
            .controlSize(.extraLarge)
    }
}

#Preview {
    RestaurantView()
}
