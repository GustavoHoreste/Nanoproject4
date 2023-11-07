//
//  RestaurantsModel.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import Foundation


//MARK: - Model

struct RestaurantModel: Identifiable{
    let id = UUID()
    let name: String
    let description: String
    let imageRest: String
    let locationRest: String
    let rating: String
    let isFavorito: Bool
}
