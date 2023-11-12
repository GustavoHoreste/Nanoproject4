//
//  CloudKitManager.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 09/11/23.
//

import UIKit
import CloudKit

enum IdentifierKeys: String{
    case identifierContainer = "iCloud.gustavoHoreste.NanoProject4"
    case recordType = "Restourants"
}

final class CloudKitManager: ObservableObject{
    
    private func sendPushNotification(for restaurantName: String) {
        CloudKitPushNotificationViewModel.shared.sendPushNotification(restaurantName: restaurantName)
    }
    
    func addItemInRecordAndNotify(name: String, description: String) {
            let newRestaurant = CKRecord(recordType: IdentifierKeys.recordType.rawValue)
            newRestaurant["name"] = name
            newRestaurant["description"] = description

            saveItens(record: newRestaurant)

            // Envie notificação push para novos restaurantes
            sendPushNotification(for: name)
        }
    
    static let shared = CloudKitManager()
    let dataBaseConteiner = CKContainer(identifier: IdentifierKeys.identifierContainer.rawValue).publicCloudDatabase

    @Published var restaurants: [RestaurantModel]  = []
    
    private init() {
        self.fetchRequest()
    }
    
    //MARK: - Adionar itens a um record
    func addItemInRecord(name: String, description: String){
       let newRestaurant = CKRecord(recordType: IdentifierKeys.recordType.rawValue)
        newRestaurant["name"] = name
        newRestaurant["description"] = description
//        newRestaurant["idItem"] = id.uuidString
        saveItens(record: newRestaurant)
    }
    
    
    func updateItems(restaurant: RestaurantModel){
        let record = restaurant.recordID
        record["name"] = "NEW NAME"
        saveItens(record: record)
    }
    
    
    func deleteItem(indeSet: IndexSet){
        guard let index = indeSet.first else { return }
        let restaurant = restaurants[index]
        let record = restaurant.recordID
        
        dataBaseConteiner.delete(withRecordID: record.recordID) {
            [weak self] returnedRecordID, returnedError in
            DispatchQueue.main.async {
                self?.restaurants.remove(at: index)
            }
        }
    }
    
    
    //MARK: - Salvar item no CloudKit
    func saveItens(record: CKRecord){
        dataBaseConteiner.save(record) { _, error in
            if error != nil{
                print("🚨 -> Error em salvar o record: \(String(describing: error)))")
            }
        }
        DispatchQueue.main.async {
            self.fetchRequest()
        }
    }
    
//    func saveItens(record:CKRecord){
//            CKContainer.default().publicCloudDatabase.save(record) {
//                _, error in
//                if error != nil{
//                    print("Error saving record: (error)")
//                } else {
//                    DispatchQueue.main.async {
////                        self.texts = ""
////                        self.fetchRequest()
//                    }
//                }
//            }
//        }

    
    //MARK: - Busca os dados no banco
    func fetchRequest(){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: IdentifierKeys.recordType.rawValue, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        dataBaseConteiner.perform(query, inZoneWith: nil) {
            records, error in 
            if let error = error {
                print("Error fetching records: \(error)")
            } else if let records = records {
                let fetchedRestaurants = records.map { RestaurantModel(recordID: $0,
                                                                       name: $0["name"] as? String ?? "",
                                                                       description: $0["description"] as? String ?? "",
                                                                       imageRest: UIImage(resource: .restauranteAsset),
                                                                       locationRest: $0["namerest"] as? String ?? "",
                                                                       rating: "23",
                                                                       isfavorite: false)}
                DispatchQueue.main.async {
//                    self.restaurants.removeAll()
                    self.restaurants = fetchedRestaurants
                }
            }
        }
    }
    
//    //MARK: - Busca os dados no banco
//    func fetchRequest(){
//        let query = CKQuery(recordType: IdentifierKeys.recordType.rawValue, predicate: NSPredicate(value: true))
//        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
//        let queryOperation = CKQueryOperation(query: query)
//        
//        queryOperation.recordMatchedBlock = { [weak self] (returdID, returnResult) in
//            switch returnResult{
//            case .success(let records):
//                let fetchedRestaurants = records.map(<#T##transform: ((CKRecord.FieldKey, CKRecordValueProtocol)) throws -> T##((CKRecord.FieldKey, CKRecordValueProtocol)) throws -> T#>)
//            case .failure(let error ):
//                print("error em recordMatchedBlock\(error)")
//            }
//        }
//        
//        dataBaseConteiner.perform(query, inZoneWith: nil) {
//            records, error in
//            if let error = error {
//                print("Error fetching records: \(error)")
//            } else if let records = records {
//                let fetchedRestaurants = records.map { RestaurantModel(recordID: $0, name: $0["name"] as? String ?? "",
//                                                                       description: $0["description"] as? String ?? "",
//                                                                       imageRest: UIImage(resource: .restauranteAsset),
//                                                                       locationRest: $0["namerest"] as? String ?? "",
//                                                                       rating: "23",
//                                                                       isfavorite: false)}
//                DispatchQueue.main.async {
////                    self.restaurants.removeAll()
//                    self.restaurants = fetchedRestaurants
//                }
//            }
//        }
//    }
}
