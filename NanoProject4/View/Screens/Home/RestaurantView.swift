//
//  RestaurantView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import SwiftUI

struct RestaurantView: View {
    @EnvironmentObject var viewModel: RestaurantViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 21){
                    ForEach(viewModel.Restaurants) { restaurant in
                        NavigationLink {
                            RestaurantRow(restaurant: restaurant)
                        } label: {
                            CellRestaurantView(restaurant: restaurant)
                        }
                    }
                }.sheet(isPresented: $viewModel.isOpen, content: {
                    SheetNewRest()
                })
                
            }.navigationTitle("Restaurantes")
                .toolbar {
                    Button(action: {
                        viewModel.togleSheetAddRest()
                        
                    }, label: {
                        Image(systemName: "plus")
                            .tint(.gray)
    
                    }).buttonStyle(.borderedProminent)
                }
        }
    }
}

#Preview {
    RestaurantView()
        .environmentObject(RestaurantViewModel())
}
