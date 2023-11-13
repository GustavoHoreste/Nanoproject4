//
//  CellRestaurantView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



struct CellRestaurantView: View {
    var restaurant: RestaurantModel
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(width: 380, height: 450)
                    .foregroundStyle(.brown)
                    .clipShape(RoundedCorner(radius: 15))
                    
                VStack(spacing: 0){
                    
                    if let image = restaurant.imageRest{
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 358, height: 335)
                            .clipShape(RoundedCorner(radius: 13, corners: [.topLeft, .topRight]))
                    }
                    
                    HStack{
                        Text(restaurant.name)
                            .font(.system(size: 26, weight: .black))
                            .foregroundStyle(Color(UIColor(.white)))
                            .lineLimit(2)
                       
                        Spacer()
                        
                        NavigationLink {
                            RestaurantRow(restaurant: restaurant)
                        } label: {
                            Text("Abrir")
                        }.buttonStyle(.borderedProminent)
                            .controlSize(.extraLarge)
                        
                        
                    }.padding()
                        .background(.brown)
                        .frame(width: 358)
                        .clipShape(RoundedCorner(radius: 13, corners: [.bottomLeft, .bottomRight]))
                }
            }
        }
    }
}

#Preview {
    CellRestaurantView(restaurant: RestaurantsAsset.restaurants.first!)
}
