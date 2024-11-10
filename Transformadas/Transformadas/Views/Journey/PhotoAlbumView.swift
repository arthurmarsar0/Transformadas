//
//  PhotoAlbumView.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 07/11/24.
//

import SwiftUI

struct PhotoAlbumView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color.bege
                .ignoresSafeArea()
            VStack {
                HStack{
                    Text("Minhas Fotos")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(.marrom)
                    Spacer()
                }
                ScrollView{
                    //TODO: Colocar algo semelhante a lógica de documentos
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundStyle(.preto)
                }
            }
        }
    }
    
//    func showMore() {
//        
//    }
}

#Preview {
    PhotoAlbumView()
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}



