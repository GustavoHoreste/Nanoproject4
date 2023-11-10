//
//  RestaurantView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import SwiftUI

struct RestaurantView: View {
    @StateObject var viewModel = RestaurantViewModel.shared
    
    var body: some View {
        NavigationStack{
            RestaurantListView(restuarants: viewModel.restaurants)
                .navigationTitle("Restaurantes")
                .sheet(isPresented: $viewModel.isOpenSheet, content: {
                    SheetNewRest()
                })
                .toolbar {
                    toolbarButton
                }
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
