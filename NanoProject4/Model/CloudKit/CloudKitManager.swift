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
    let dataBaseConteiner = CKContainer(identifier: IdentifierKeys.identifierContainer.rawValue).publicCloudDatabase
    let myRecord = CKRecord(recordType: IdentifierKeys.recordType.rawValue)
    
    
    //MARK: - Adionar itens a um record
    func addItemInRecord(){
        
    }
    
    
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
        
    }
}
