//
//  Services.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI


struct Services: View {
    @State var viewType: Bool = true
    @State var searchText: String = ""
    @State var selectedFilter: String = "Todos"
    @StateObject var viewModel = ServiceViewModel()
    @State var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                
                Color.bege.ignoresSafeArea()
                
                VStack {
                    
                    if(viewType == false){
                        MapView(selectedFilter: $selectedFilter, showFilters: true)
                    }else{
                        ListView(selectedFilter: $selectedFilter)
                    }
                }
                
                .toolbar{
                    
                    ToolbarItem(placement: .topBarLeading){
                        Text("Guia de Serviços")
                            .font(.system(size: 28, weight: .semibold))
                        
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            viewType.toggle()
                        }) {
                            if(viewType == true){
                                Image(systemName: "map.fill")
                                    .foregroundStyle(.black)
                            }else{
                                Image(systemName: "list.bullet.circle.fill")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            isShowingSheet.toggle()
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundStyle(.black)
                        }
                    }
                }
                
            }
            .sheet(isPresented: $isShowingSheet) {
                InfoSheetView()
            }
        }
    }
}


#Preview {
    
    Services().modelContainer(for: [Effect.self,
                                    User.self,
                                    Entry.self,
                                    Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
