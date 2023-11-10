//
//  RestaurantsModel.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import Foundation
import CloudKit
import UIKit


//MARK: - Model

struct RestaurantModel: Identifiable{
    let id = UUID()
    let name: String
    let description: String
    let imageRest: UIImage?
    let locationRest: String
    let rating: String
    var isfavorite: Bool
    
    mutating func togleIsfavorite(){
        self.isfavorite.toggle()
    }
}

struct RestaurantsCloudModel: Hashable{
    let recordID: CKRecord
    let nameRest: String
    let description: String
}


