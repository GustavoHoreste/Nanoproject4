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
    let recordID: CKRecord
    let name: String
    let description: String
    let imageRest: UIImage?
    let locationRest: String
    let rating: String
    var isfavorite: Bool
    
}
//fazer uma funcao que ire receber um ckasset e retorna um uiimage
//func convertCKAssetToUIImage(imageRestInFormatCKAsset: CKAsset) -> UIImage? {
//    do {
//        let imageData = try Data(contentsOf: imageRestInFormatCKAsset.fileURL!)
//        return UIImage(data: imageData)
//    } catch {
//        print("Erro ao converter CKAsset em UIImage: \(error)")
//        return nil
//    }
//}


struct RestaurantsCloudModel: Hashable{
    let recordID: CKRecord
    let nameRest: String
    let description: String
    let imageRest: CKAsset?

}


