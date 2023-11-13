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
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(restuarants) { restaurant in
                    NavigationLink{
                        RestaurantRow(restaurant: restaurant)
                    } label: {
                        CellRestaurantView(restaurant: restaurant)
                            .scaleEffect(restaurant.id == restaurant.id && showDetailsPage ? 1 : 0.93 )
                    }.buttonStyle(ScaledButtonStyle())
                }
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
