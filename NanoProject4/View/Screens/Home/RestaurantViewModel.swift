//
//  RestaurantViewModel.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import Foundation
import SwiftUI
import PhotosUI
import CloudKit


//MARK: - ViewModel
class RestaurantViewModel: ObservableObject{

    @Published var restaurants: [RestaurantModel] = RestaurantsAsset.restaurants
    @Published var isOpenSheet: Bool = false
    @Published var description: String = ""
    @Published var nameRest: String = ""
    
    @Published  var selectedImage: UIImage? = UIImage(resource: .restauranteAsset)
    @Published var imageSelection: PhotosPickerItem? = nil{
        didSet{
             Task {
                try? await setImage(from: imageSelection)
            }
        }
    }
    
    func togleSheetAddRest(){
        self.isOpenSheet.toggle()
    }
      
    
    public func resetVariables(){
        nameRest = ""
        description = ""
        selectedImage = UIImage(resource: .restauranteAsset)
        imageSelection = nil
    }
    
    
    public func creatNewRestaurant(){
        let newRestaurant = RestaurantModel(recordID: CKRecord(recordType: IdentifierKeys.recordType.rawValue),
                                            name: nameRest,
                                            description: description,
                                            imageRest: selectedImage,
                                            locationRest: "Tagua-Tinga",
                                            rating: "4.9",
                                            isfavorite: false)
        
        CloudKitManager.shared.addItemInRecordAndNotify(name: nameRest, description: description, imageRest: selectedImage)
        self.restaurants.append(newRestaurant)
    }
    
    
    ////funcao que recebe um fotoPicker e converte em UIImage
    @MainActor
    private func setImage(from selection: PhotosPickerItem?) async throws {
        guard let selection else { return }
        do{
            if let data = try await selection.loadTransferable(type: Data.self){
              selectedImage = UIImage(data: data)
            }
        }catch{
            print("🚨 -> Error em converter o data do picker para UIImage")
        }
        
    }
}


//MARK: - Instancia asset de RestaurantModel para teste
struct RestaurantsAsset{
   static let restaurants: [RestaurantModel] = [
    RestaurantModel(recordID: CKRecord(recordType: "Restourants"),
                    name: "c",
                         description: "hamburgueria hambúrguer burguer burger smash blend sanduíche artesanal angus hot dog cachorro quente pizzaria pizza crepe pastel pastelaria esfiha esfirra massas lasanha macarrão bolonhesa peito coxinha da asa asinha coxa e sobrecoxa frango frito assado grelhado feijoada carne de sol picanha costela costelinha fraldinha contra filé mignon strogonoff parrilla maminha alcatra churrascaria churrasco churrasquinho espeto espetinho jantinha janta almoço refeição prato executivo restaurante marmita gourmet acaiteria esuíno suína risoto fettuccine petisco frutos do mar camarão peixe barbecue batata saudável fitness açaí",
                         imageRest: UIImage(resource: .restauranteAsset),
                         locationRest: "Vicente-Pires",
                         rating: "4.9",
                         isfavorite: false),
         
    RestaurantModel(recordID: CKRecord(recordType: "Restourants"),
                    name: "Prazeres do Planalto Grill",
                        description: "Carnes suculentas, preparadas com maestria e servidas com um toque regional, celebrando os prazeres do planalto central.",
                        imageRest: UIImage(resource: .restauranteAsset),
                        locationRest: "SCS Quadra 3, Bloco A, Asa Sul, Brasília",
                        rating: "4.9",
                        isfavorite: false)
     ]
}






