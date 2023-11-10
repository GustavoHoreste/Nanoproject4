//
//  RestaurantRowView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import SwiftUI


struct RestaurantRow: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: RestaurantViewModel
    var restaurant: RestaurantModel
    
    var body: some View {
        
        GeometryReader{ proxy in
            VStack{
                ZStack(alignment: .bottom){
                    if let image = restaurant.imageRest{
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .ignoresSafeArea(edges: .top)
                                .frame(width: proxy.size.width, height: proxy.size.height/2)
                    }
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text(restaurant.name)
                                .bold()
                            
                            Text(restaurant.locationRest)
                                .bold()
                        }
                
                        Spacer()
                        
                        VStack {
                            Text("Nota \(restaurant.rating)")
                                .bold()
                                .font(.title)
                            
                            Button(action: {
//                                self.vm.toogleValueIsfavorite(from: self.restaurant)
                                print("Nome e: \(restaurant.name)")
                            }, label: {
                                Image(systemName: restaurant.isfavorite ? "heart.fill" : "heart")
                                    .tint(.red)
                                    .symbolRenderingMode(.hierarchical)
                                    .font(.system(size: 28))

                            })
                        }
                        
                    }.padding()
                        .background(Color(.gray.withAlphaComponent(0.8)))
                    
                }
                            
                ScrollView{
                    Text(restaurant.description)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.gray)
                        .padding()
                }
        
            }.navigationBarBackButtonHidden(true)
             .toolbar {
                 toolbarItens
             }
        }
    }
    
    private var toolbarItens: some View {
        Button(action: {
            dismiss()
            
        }, label: {
            Image(systemName: "xmark.circle.fill")
                .tint(.backButton)
                .font(.system(size: 20))
        })
    }
}

#Preview {
    RestaurantRow(restaurant: RestaurantsAsset.restaurants.first!)
}
