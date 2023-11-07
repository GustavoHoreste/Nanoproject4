//
//  RestaurantRowView.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import SwiftUI


struct RestaurantRow: View {
    var restaurant: RestaurantModel
    
    var body: some View {
        Text(restaurant.description)
            .padding()
    }
}

#Preview {
    RestaurantRow(restaurant: RestaurantModel(name: "Apache Hamburgueria",
                                              description: "hamburgueria hambúrguer burguer burger smash blend sanduíche artesanal angus hot dog cachorro quente pizzaria pizza crepe pastel pastelaria esfiha esfirra massas lasanha macarrão bolonhesa peito coxinha da asa asinha coxa e sobrecoxa frango frito assado grelhado feijoada carne de sol picanha costela costelinha fraldinha contra filé mignon strogonoff parrilla maminha alcatra churrascaria churrasco churrasquinho espeto espetinho jantinha janta almoço refeição prato executivo restaurante marmita gourmet acaiteria esuíno suína risoto fettuccine petisco frutos do mar camarão peixe barbecue batata saudável fitness açaí",
                                              imageRest: "RestauranteAsset",
                                              locationRest: "Vicente-Pires",
                                              rating: "4.9"))
}
