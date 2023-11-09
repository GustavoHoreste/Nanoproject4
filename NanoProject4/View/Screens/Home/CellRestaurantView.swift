//
//  CellRestaurantView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import SwiftUI

struct CellRestaurantView: View {
    var restaurant: RestaurantModel
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .bottom){
            
                if let image = restaurant.imageRest{
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 358, height: 335)
                        .cornerRadius(13)
                }
                
                HStack{
                    Text(restaurant.name)
                        .font(.system(size: 26, weight: .black))
                        .foregroundStyle(Color(UIColor(.white)))
                   
                    Spacer()
                    
                    NavigationLink {
                        RestaurantRow(restaurant: restaurant)
                    } label: {
                        Text("Abrir")
//                            .background(.blue)
                            .font(.system(size: 20))
                    }

                    
                    
                }.padding()
                    .background(Color(UIColor(.gray).withAlphaComponent(0.8)))
                    .frame(width: 358)
                    .clipShape(.rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 13,
                        bottomTrailingRadius: 13,
                        topTrailingRadius: 0
                    ))
            }
        }
    }
}

#Preview {
    CellRestaurantView(restaurant: RestaurantModel(name: "Apache ",
                                              description: "hamburgueria hambúrguer burguer burger smash blend sanduíche artesanal angus hot dog cachorro quente pizzaria pizza crepe pastel pastelaria esfiha esfirra massas lasanha macarrão bolonhesa peito coxinha da asa asinha coxa e sobrecoxa frango frito assado grelhado feijoada carne de sol picanha costela costelinha fraldinha contra filé mignon strogonoff parrilla maminha alcatra churrascaria churrasco churrasquinho espeto espetinho jantinha janta almoço refeição prato executivo restaurante marmita gourmet acaiteria esuíno suína risoto fettuccine petisco frutos do mar camarão peixe barbecue batata saudável fitness açaí",
                                              imageRest: UIImage(resource: .restauranteAsset),
                                              locationRest: "Vicente-Pires",
                                                   rating: "4.9", isfavorite: false))
}
