//
//  PhotosJourneyView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 10/11/24.
//

import SwiftUI
import SwiftData

struct PhotosJourneyView: View {
    var photos: [(Date, Data)]
    var startingPhoto: Int
    
    @State var selectedPhoto: Int = 0
    @EnvironmentObject var tabViewModel: TabViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            
            TabView(selection: $selectedPhoto) {
                ForEach(0..<photos.count, id: \.self) { i in
                    if let photo = EntryModel.dataToImage(data: photos[i].1){
                        photo
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.scaledToFill()
                            //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .clipped()
                            .tag(i)
                    }
                    
                }
            }
            .tabViewStyle(PageTabViewStyle())
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .toolbarBackground(.ultrathin)
            .toolbarBackgroundVisibility(.visible)
            
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        HStack{
                            Image(systemName: "chevron.left")
                            Text("Voltar")
                        }
                        .foregroundStyle(.preto)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("\(photos[selectedPhoto].0.dayNumber) \(photos[selectedPhoto].0.monthString.prefix(3)) \(photos[selectedPhoto].0.yearNumber)")
                        .font(.system(size: 17, weight: .semibold))
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        seeDay(date: photos[selectedPhoto].0)
                    }) {
                        Text("Ver Dia")
                            .foregroundStyle(.vermelho)
                    }
                }
            }.onAppear {
                selectedPhoto = startingPhoto
                
            }
        }.onAppear {
            removeNavBarBackground()
        }
    }
    
    func seeDay(date: Date) {
        tabViewModel.selectedTab = 1
        tabViewModel.isShowingEntrySheet = true
        tabViewModel.selectedDate = date
    }
}
