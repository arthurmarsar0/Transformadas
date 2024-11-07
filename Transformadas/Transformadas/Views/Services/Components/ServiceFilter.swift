//
//  ServiceFilter.swift
//  Transformadas
//
//  Created by Alice Barbosa on 05/11/24.
//

import SwiftUI

struct ServiceFilter: View {
    @Binding var searchText: String
    
    var body: some View {
        ZStack (alignment: .leading){
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 36)
                .foregroundStyle(.cinzaMuitoClaro)
            HStack{
                Image(systemName: "magnifyingglass")
                    .padding()
                
                TextField("Buscar", text: $searchText)
            }
        }

    }
}

#Preview {
    ServiceFilter(searchText: .constant(""))
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
