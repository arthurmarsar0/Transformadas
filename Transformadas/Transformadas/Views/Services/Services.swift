//
//  Services.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI

let categories = [
    ("Todos", nil),
    ("Médicos", "cross.fill"),
    ("Psicológicos", "brain.fill"),
    ("Jurídicos", "list.clipboard.fill"),
    ("Proteção", "light.beacon.min.fill"),
    ("Sociais", "person.2.fill")
]


struct Services: View {
    @State var viewType: Bool = false
    @State var searchText: String = ""
    @State var selectedFilter: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal){
                    HStack{
                        ForEach(0..<categories.count, id: \.self) { index in
                            let (title, symbol) = categories[index]
                            
                            Button(action: {
                                selectedFilter = index
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(selectedFilter == index ? .purple : .gray) 
                                        .frame(height: 32)
                                    
                                    HStack(spacing: 8) {
                                        if let symbol = symbol {
                                            Image(systemName: symbol)
                                                .foregroundColor(selectedFilter == index ? .white : .black)
                                        }
                                        Text(title)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(selectedFilter == index ? .white : .black)
                                    }
                                    .padding(.horizontal, 12)
                                }
                            }
                        }
                    }
                    
                }
                
                List{
                    
                    
                }
                .searchable(text: $searchText)
                
                
                if(viewType == false){
                    MapView()
                }else{
                    ListView()
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
                        Image(systemName: "map.fill")
                            .foregroundStyle(.black)
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        
    }
    
}

#Preview {
    Services()
}
