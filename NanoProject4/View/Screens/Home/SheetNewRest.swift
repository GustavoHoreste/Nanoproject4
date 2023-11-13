//
//  SheetNewRest.swift
//  NanoProject4
//
//  Created by Gustavo Horestee Santos Barros on 08/11/23.
//

import SwiftUI
import PhotosUI

struct SheetNewRest: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = RestaurantViewModel.shared
    @State var isPresentPicker: Bool = false
    

    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center){
                
                if let image = viewModel.selectedImage{
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                }
                

                VStack(alignment: .leading){
                    Text("Adicione um nome")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.gray)
                    
                    TextField("Nome ", text: $viewModel.nameRest)
                        .frame(height: 50)
                        .background(in: RoundedRectangle(cornerRadius: 13))
                    
                    Text("Adicione uma descrição")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.gray)

                    
                    TextField("Descricao", text: $viewModel.description, axis: .vertical)
                        .lineLimit(10)
                        .frame(height: 50)
                        .background(in: RoundedRectangle(cornerRadius: 13))
                    
                    
                    Text("Adicione imagem")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.gray)

                
                    Menu {
                        Button {
                        } label: {
                            Label("Cancel", systemImage: "xmark")
                        }

                        Button {
                            isPresentPicker.toggle()
                        } label: {
                            Label("Add Photo", systemImage: "photo.on.rectangle")
                        }
    
                        
                    } label: {
                        Label("Imagem", systemImage: "filemenu.and.selection")
                            .frame(width: 120, height: 50)
                            .background(.black)
                            .background(in: RoundedRectangle(cornerRadius: 13))
                            .tint(.white)

                    }.photosPicker(isPresented: $isPresentPicker,
                                   selection: $viewModel.imageSelection,
                                   matching: .images,
                                   photoLibrary: .shared())
                }
               
                
                Spacer()
                
                Button("Adicionar") {
                    viewModel.creatNewRestaurant()
                    viewModel.resetVariables()
                    dismiss()
                    
                }.buttonStyle(.borderedProminent)
                 .controlSize(.large)
                 .tint(.green)

            }.navigationTitle("Novo restaurante")
                .padding()
                .toolbar {
                   Button(action: {
                       dismiss()
                       
                   }, label: {
                       Image(systemName: "xmark.circle.fill")
                           .tint(.backButton)
                           .font(.system(size: 20))
                   })
               }
        }
    }
}

#Preview {
    SheetNewRest()
}
