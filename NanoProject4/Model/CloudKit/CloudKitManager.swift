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
    
    static let shared = CloudKitManager()
    
    let dataBaseConteiner = CKContainer(identifier: IdentifierKeys.identifierContainer.rawValue).publicCloudDatabase

    @Published var restaurantItens: [RestaurantModel]  = []
    private var itensReturned: [RestaurantModel] = []

    
    
    //MARK: - Adionar itens a um record
    func addItemInRecord(name: String, description: String){
       let newRestaurant = CKRecord(recordType: IdentifierKeys.recordType.rawValue)
        newRestaurant["name"] = name
        newRestaurant["description"] = description
        saveItens(record: newRestaurant)
    }
    
    
    
    //MARK: - Salvar item no CloudKit
    private func saveItens(record: CKRecord){
        dataBaseConteiner.save(record) { _, error in
            if error != nil{
                print("🚨 -> Error em salvar o record: \(String(describing: error)))")
            }
        }
    }
    
    
    
    //MARK: - Busca os dados no banco
    public func fetchRequest(){
        let query = CKQuery(recordType: IdentifierKeys.recordType.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let queryOperation = CKQueryOperation(query: query)
        
    
        self.restaurantItens = [RestaurantModel]()
        self.itensReturned = [RestaurantModel]()
        
        queryOperation.recordMatchedBlock = { [weak self] (returdID, returnResult) in
            switch returnResult{
            case .success(let record):
                guard
                    let name = record["name"] as? String,
                    let description = record["description"] as? String,
                    let imageRestAsset = record["imageRest"] as? CKAsset
                else {
                    print("Erro: Valores inválidos no record.")
                    return
                }
                
                DispatchQueue.main.sync {
                    if let imageConverted = imageRestAsset.toUIImage(){
                        self?.itensReturned.append(RestaurantModel(recordID: record,
                                                                   name: name,
                                                                   description: description,
                                                                   imageRest: imageConverted,
                                                                   locationRest: "Tagua-Tinga",
                                                                   rating: "4.9",
                                                                   isfavorite: false))
                    }
                }
                
            case .failure(let error ):
                print("error em recordMatchedBlock\(error)")
            }
        }
        
        queryOperation.queryResultBlock = { [weak self] result in
            DispatchQueue.main.async {
                self?.restaurantItens = self?.itensReturned ?? []
            }
        }
        
        dataBaseConteiner.add(queryOperation)
    }
    
    
    
    //MARK: - Transforma a imagem em CKAsset
    private func convertUIimageInCKAsset(_ imageRest: UIImage?) -> CKAsset?{
        let imageFilename: String = "RestauranteAsset"
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(imageFilename),
              let data = imageRest?.jpegData(compressionQuality: 0.5)
        else { return nil }
                
        do{
            try data.write(to: url)
            return CKAsset(fileURL: url)
            
        }catch let error{
            print("Deu erro no save e no image: \(error)")
        }

        return nil
    }
    
    
    private func updateItems(restaurant: RestaurantModel){
        let record = restaurant.recordID
        record["name"] = "NEW NAME"
        saveItens(record: record)
    }
    
    
    func deleteItem(indeSet: IndexSet){
        guard let index = indeSet.first else { return }
        let restaurant = restaurantItens[index]
        let record = restaurant.recordID

        dataBaseConteiner.delete(withRecordID: record.recordID) {
            [weak self] returnedRecordID, returnedError in
            if let error = returnedError, error != nil {
                print("error em deletar: \(error)")
            }
            DispatchQueue.main.async {
                self?.restaurantItens.remove(at: index)
            }
        }
    }
    
    
    private func sendPushNotification(for restaurantName: String) {
        CloudKitPushNotificationViewModel.shared.sendPushNotification(restaurantName: restaurantName)
    }
    
    
    func addItemInRecordAndNotify(name: String, description: String, imageRest: UIImage!) {
        guard let imageConverted = convertUIimageInCKAsset(imageRest) else {return}
            
        let newRestaurant = CKRecord(recordType: IdentifierKeys.recordType.rawValue)
        newRestaurant["name"] = name
        newRestaurant["description"] = description
        newRestaurant["imageRest"] = imageConverted
        saveItens(record: newRestaurant)

        // Envie notificação push para novos restaurantes
        sendPushNotification(for: name)
    }
    
    public func toggleFavoriteStatus(uuidItem: UUID) {
        if let index = self.restaurantItens.firstIndex(where: { $0.id == uuidItem }) {
            self.restaurantItens[index].isfavorite.toggle()
        } else {
            print("ID não encontrado")
        }
    }
    
    func returnIdexSet(_ restaurantItem: RestaurantModel) -> IndexSet{
        var index = IndexSet()
        if let rest = self.restaurantItens.firstIndex(where: {$0.id == restaurantItem.id}){
            index.insert(rest)
        }
        return index
    }
}


extension CKAsset {
    func toUIImage() -> UIImage? {
        if let data = NSData(contentsOf: self.fileURL!) {
            return UIImage(data: data as Data)
        }
        return nil
    }
}
