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
    @StateObject var viewModel = ServiceViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack{
                
                Color.bege.ignoresSafeArea()
                
                VStack {
                    ScrollView(.horizontal){
                        categorySection()
                        
                    }
                    
                    if(viewType == false){
                        MapView(selectedFilter: selectedFilter)
                            .background(Color.bege)
                    }else{
                        ListView(selectedFilter: selectedFilter)
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
    func categorySection() -> some View {
        HStack{
            ForEach(Category.allCases, id: \.self){ category in
                Button(action: {
                    selectedFilter = category.name
                    viewModel.filterServices(by: selectedFilter)
                    print(selectedFilter)
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(selectedFilter == category.name ? .rosa : .cinzaMuitoClaro)
                            .frame(height: 32)
                        HStack(spacing: 8) {
                            Image(systemName: category.symbol)
                                .foregroundColor(selectedFilter == category.name ? .white : .cinzaEscuro)
                                
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
