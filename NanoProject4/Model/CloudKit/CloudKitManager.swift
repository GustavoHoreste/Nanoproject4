//
//  CloudKitManager.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 09/11/23.
//

import UIKit
import CloudKit

private enum IdentifierKeys: String{
    case identifierContainer = "iCloud.gustavoHoreste.NanoProject4"
    case recordType = "Restaurentes"
}

final class CloudKitManager: ObservableObject{
    
    @Published var texts: String = ""
    @Published var restaurants: [RestaurantsCloudModel]  = []
    
    let dataBaseConteiner = CKContainer(identifier: IdentifierKeys.identifierContainer.rawValue).publicCloudDatabase
    let myRecord = CKRecord(recordType: IdentifierKeys.recordType.rawValue)
    
    
    //MARK: - Adionar itens a um record
    private func addItemInRecord(name: String, description: String){
        let newRestaurant = CKRecord(recordType: "Restourants")
        newRestaurant["name"] = name
        newRestaurant["description"] = description
        saveItens(record: newRestaurant)
    }
    
    func updateItems(restaurant: RestaurantsCloudModel){
        let record = restaurant.recordID
        record["name"] = "NEW NAME"
        saveItens(record: record)
    }
    
    func deleteItem(indeSet: IndexSet){
        guard let index = indeSet.first else { return }
        let restaurant = restaurants[index]
        let record = restaurant.recordID
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) {
            [weak self] returnedRecordID, returnedError in
            DispatchQueue.main.async {
                self?.restaurants.remove(at: index)
            }
        }
    }
    
    /*private func saveItem(record:CKRecord){
        CKContainer.default().publicCloudDatabase.save(record) {
            _, error in if let error = error{
                print("Error saving record: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.texts = ""
                    //self.fetchRequest
                }
            }
        }
    }*/
    
    
    //MARK: - Salvar item no CloudKit
    func saveItens(record: CKRecord){
        dataBaseConteiner.save(record) { result, error in
            if error != nil{
                print("🚨 -> Error em salvar o record")
            }
        }
    }
    
    
    //MARK: - Busca os dados no banco
    func fetchRequest(){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurants", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) {
            records, error in if let error = error {
                print("Error fetching records: \(error)")
            } else if let records = records {
                let fetchedRestaurants = records.map { RestaurantsCloudModel(recordID: $0, nameRest: $0["namerest"] as! String, description: $0["description"] as! String)}
                DispatchQueue.main.async {
                    self.restaurants = fetchedRestaurants
                }
            }
        }
    }
}
