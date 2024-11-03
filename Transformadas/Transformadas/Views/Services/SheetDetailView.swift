//
//  SheetDetailView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 31/10/24.
//

import SwiftUI

struct SheetDetailView: View {
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
                                    .foregroundStyle(.verde)
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
            }
            .padding()
            Spacer()
        }
    }
}

