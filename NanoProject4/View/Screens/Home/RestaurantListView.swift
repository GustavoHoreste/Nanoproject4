//
//  RestaurantListView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 09/11/23.
//

import SwiftUI

struct RestaurantListView: View {
    var restuarants: [RestaurantModel]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 21){
                ForEach(restuarants) { restaurant in
                    NavigationLink {
                        RestaurantRow(restaurant: restaurant)
                    } label: {
                        CellRestaurantView(restaurant: restaurant)
                    }
                }
            }
        }
    }
}

#Preview {
    RestaurantListView(restuarants: RestaurantsAsset.restaurants)
}
