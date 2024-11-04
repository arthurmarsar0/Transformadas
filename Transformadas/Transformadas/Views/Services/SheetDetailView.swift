//
//  SheetDetailView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 31/10/24.
//

import SwiftUI



struct SheetDetailView: View {
    
    @State var selectedFilter: String = "Todos"
    
    private func openInWaze() {
        let urlString = "waze://?ll=\(service.coordinate.latitude),\(service.coordinate.longitude)&navigate=yes"
            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Caso Waze não esteja instalado
                let fallbackURL = "https://www.waze.com/ul?ll=\(service.coordinate.latitude),\(service.coordinate.longitude)&navigate=yes"
                if let fallbackURL = URL(string: fallbackURL) {
                    UIApplication.shared.open(fallbackURL)
                }
            }
        }
    
    
    var service: Service
    
    var body: some View {
        ZStack{
            Color.bege.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16){
                
                VStack(alignment: .leading){
                    HStack {
                        ForEach(service.categories , id: \.self) { category in
                            if !category.symbol.isEmpty{
                                Image(systemName: category.symbol)
                                    .foregroundStyle(category.color)
                            }
                        }
                    }
                }
                VStack(alignment: .leading){
                    
                    Text(service.name)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(.rosa)
                }
                
                VStack(alignment: .leading){
                    Text("Endereço e Contato")
                        .font(.system(size: 18, weight: .bold))
                    HStack{
                        Image(systemName: "phone.fill")
                        Text(service.telephone)
                        
                    }
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                        Text(service.address.street + ", " + service.address.neighborhood + ", " + service.address.city)
                    }
                }
                
                VStack(alignment: .leading){
                    Text("Sobre")
                        .font(.system(size: 18, weight: .bold))
                    Text(service.description)
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 180)
                        .foregroundStyle(.black)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black, lineWidth: 2))
                    MapView(selectedFilter: $selectedFilter, showFilters: false)
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                }
                .onTapGesture {
                    openInWaze()
                }
            }
            .padding()
            Spacer()
        }
    }
}

