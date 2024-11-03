//
//  ListComponent.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI

struct ListComponent: View {
    var service: Service
    var body: some View {
        ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 8)
                .frame(height: 128)
                .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        ForEach(service.categories , id: \.self) { category in
                            if !category.symbol.isEmpty{
                                Image(systemName: category.symbol)
                                    .foregroundStyle(.verde)
                            }
                        }
                    }
                    Text(service.name)
                        .foregroundColor(.preto)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .lineLimit(1)
                        
                    Text(service.address.street + " " + service.address.neighborhood)
                        .foregroundColor(.cinzaEscuro)
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .lineLimit(1)
                    //TODO: Trocar pra calcular a distancia do usuario pro local em km
                    Text(service.address.city)
                        .foregroundColor(.cinzaEscuro)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .lineLimit(1)
                }
                .padding()
                
        }

    }
}

//#Preview {
//    ListComponent()
//}
