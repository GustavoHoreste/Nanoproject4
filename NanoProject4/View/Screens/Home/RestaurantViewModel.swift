//
//  RestaurantViewModel.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 07/11/23.
//

import Foundation
import SwiftUI
import PhotosUI


//class ImagePickerViewModel: ObservableObject{
//    @Published  var selectedImage: UIImage? = nil
//    @Published var imageSelection: PhotosPickerItem? = nil{
//        didSet{
//            setImage(from: imageSelection)
//        }
//    }
//    
//    private func setImage(from selection: PhotosPickerItem?){
//        guard let selection else { return }
//        
//        Task{
//            if let data = try? await selection.loadTransferable(type: Data.self){
//                if let uiImage = UIImage(data: data){
//                    selectedImage = uiImage
//                }
//            }
//        }
//    }
//    
//}

//MARK: - ViewModel
class RestaurantViewModel: ObservableObject{

   @Published var isOpen: Bool = false
   @Published var nameRest: String = ""
   @Published var description: String = ""

   @Published  var selectedImage: UIImage? = nil
   @Published var imageSelection: PhotosPickerItem? = nil{
        didSet{
            setImage(from: imageSelection)
        }
    }
    
   @Published var Restaurants: [RestaurantModel] = [
        RestaurantModel(name: "Apache Hamburgueria",
                        description: "hamburgueria hambúrguer burguer burger smash blend sanduíche artesanal angus hot dog cachorro quente pizzaria pizza crepe pastel pastelaria esfiha esfirra massas lasanha macarrão bolonhesa peito coxinha da asa asinha coxa e sobrecoxa frango frito assado grelhado feijoada carne de sol picanha costela costelinha fraldinha contra filé mignon strogonoff parrilla maminha alcatra churrascaria churrasco churrasquinho espeto espetinho jantinha janta almoço refeição prato executivo restaurante marmita gourmet acaiteria esuíno suína risoto fettuccine petisco frutos do mar camarão peixe barbecue batata saudável fitness açaí",
                        imageRest: UIImage(resource: .restauranteAsset),
                        locationRest: "Vicente-Pires",
                        rating: "4.9",
                        isfavorite: false)
    ]
    
    
    func togleSheetAddRest(){
        self.isOpen.toggle()
    }
    
    func creatNewRestaurant(){
        print(selectedImage as Any)
        self.Restaurants.append(RestaurantModel(name: nameRest, description: description, imageRest: selectedImage, locationRest: "Teste", rating: "4.9", isfavorite: false))
    }
    
    private func setImage(from selection: PhotosPickerItem?){
        guard let selection else { return }
        
        Task{
            if let data = try? await selection.loadTransferable(type: Data.self){
                if let uiImage = UIImage(data: data){
                    selectedImage = uiImage
                }
            }
        }
    }
    
    func getPhotoInAlbum(){
        print("escolhi uma foto")
    }
    
    func takePhoto(){
        print("peguei uma foto")
    }
    
    func cancelMenu(){
        
    }
    
    func resetVariables(){
        nameRest = ""
        description = ""
        selectedImage = nil
        imageSelection = nil
    }
}

