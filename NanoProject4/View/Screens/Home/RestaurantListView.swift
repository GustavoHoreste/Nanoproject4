//
//  RestaurantListView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 09/11/23.
//

import SwiftUI

struct RestaurantListView: View {
    var restuarants: [RestaurantModel]
    @State var showDetailsPage: Bool = false
    @State var correntItem: RestaurantModel?

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(restuarants) { restaurant in
                Button{
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                        showDetailsPage = true
                        correntItem = restaurant
                    }
                } label: {
                    CellRestaurantView(restaurant: restaurant)
                        .scaleEffect(restaurant.id == restaurant.id && showDetailsPage ? 1 : 0.93 )
                }.buttonStyle(ScaledButtonStyle())
                
            }.overlay {
                if showDetailsPage{
                    showDetailView(item: correntItem)
                }
            }
        }
    }
    
    func showDetailView(item: RestaurantModel?) -> some View{
        ScrollView{
            VStack(spacing: 21){
                RestaurantRow(restaurant: correntItem!)
                    .transition(.identity)
            }
        }
    }
}


struct ScaledButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
    
}

#Preview {
    RestaurantListView(restuarants: RestaurantsAsset.restaurants)
}
