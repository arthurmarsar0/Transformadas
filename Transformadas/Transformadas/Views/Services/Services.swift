//
//  Services.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI


struct Services: View {
    @State var viewType: Bool = false
    @State var searchText: String = ""
    @State var selectedFilter: String = "Todos"
    
    var body: some View {
        NavigationStack {
            ZStack{
                
                Color.bege.ignoresSafeArea()
                
                VStack {
                    ScrollView(.horizontal){
                        categorySection
                            //.padding(.vertical, 8)
                        
                    }
                    
                    if(viewType == false){
                        MapView()
                            .background(Color.bege)
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
}

extension Services {
    var categorySection: some View {
        HStack{
            ForEach(Category.allCases, id: \.self){ category in
                Button(action: {
                    selectedFilter = category.name
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(selectedFilter == category.name ? .rosa : .cinzaMuitoClaro)
                            .frame(height: 32)
                        HStack(spacing: 8) {
                            Image(systemName: category.symbol)
                                .foregroundColor(selectedFilter == category.name ? .white : .rosa)
                                
                            Text(category.name)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(selectedFilter == category.name ? .white : .cinzaEscuro)
                        }.padding(.horizontal, 8)
                    }
                }
            }
        }
        .padding()
    }
}


#Preview {
    
    Services()
}
