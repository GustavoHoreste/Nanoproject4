//
//  RestaurantIntentPreview.swift
//  NanoProject4
//
//  Created by Fabio Freitas on 09/11/23.
//

import SwiftUI

struct RestaurantIntentPreview: View {
    let restaurant: RestaurantModel
    
    var body: some View {
        VStack {
            if let image = restaurant.imageRest {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/))
            }
            Text(restaurant.name)
                .bold()
                .font(.headline)
            Text(restaurant.locationRest)
                .font(.subheadline)
        }
        .padding()
    }
}

#Preview {
    RestaurantIntentPreview(restaurant: RestaurantViewModel.shared.random)
}
