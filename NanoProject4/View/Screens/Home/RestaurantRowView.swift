//
//  RestaurantRowView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import SwiftUI


struct RestaurantRow: View {
    @Environment(\.dismiss) var dismiss
    @State var restaurant: RestaurantModel
    
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
                                //nao esta mudando o valor da istancia da viewmodel, apenas a copia atual da intancia. Mudar aqui
                                restaurant.togleIsfavorite()
                                
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
                
//                Spacer()
                
                ScrollView{
                    Text(restaurant.description)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.gray)
                        .padding()
                }
                

                    
                
            }.navigationBarBackButtonHidden(true)
             .toolbar {
                Button(action: {
                    dismiss()
                    
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .tint(.backButton)
                        .font(.system(size: 20))
                })

         }
        }
    }
}

#Preview {
    RestaurantRow(restaurant: RestaurantModel(name: "Apache Hamburgueria",
                                              description: "hamburgueria hambúrguer burguer burger smash blend sanduíche artesanal angus hot dog cachorro quente pizzaria pizza crepe pastel pastelaria esfiha esfirra massas lasanha macarrão bolonhesa peito coxinha da asa asinha coxa e sobrecoxa frango frito assado grelhado feijoada carne de sol picanha costela costelinha fraldinha contra filé mignon strogonoff parrilla maminha alcatra churrascaria churrasco churrasquinho espeto espetinho jantinha janta almoço refeição prato executivo restaurante marmita gourmet acaiteria esuíno suína risoto fettuccine petisco frutos do mar camarão peixe barbecue batata saudável fitness açaí",
                                              imageRest: UIImage(resource: .restauranteAsset),
                                              locationRest: "Vicente-Pires",
                                              rating: "4.9",
                                              isfavorite: false))
}
