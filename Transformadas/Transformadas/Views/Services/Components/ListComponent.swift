//
//  ListComponent.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI

struct ListComponent: View {
    var service = Service(
        ID: UUID().uuidString,  // ou qualquer ID que você queira usar
        name: "Policlínica Lessa de Andrade - Ambulatório LGBT Patrícia Gomes",
        categories: [.medical, .psychological, .social],
        email: "amblgbt@gmail.com",
        telephone: "8133557811",
        description: "A policlínica Lessa de Andrade possui o ambulatório Patrícia Gomes que oferece serviços para pessoas trans como atendimentos com clínicos gerais, endocrinologistas para hormonioterapia, atendimento psicológico, exames clínicos e profilaxia PrEP",
        address: Address(city: "Recife", street: "Estrada dos Remédios 2416", neighborhood: "Madalena"),
        coordinate: Coordinate(latitude: -8.05871, longitude: -34.90694)
    )
    
    var body: some View {
        ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 8)
                .frame(height: 128)
                .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        ForEach(service.categories , id: \.self) { category in
                            Image(systemName: category.symbol)
                                .foregroundStyle(.gray)
                        }
                    }
                    Text(service.name)
                        .foregroundColor(.gray)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .lineLimit(1)
                        
                    Text(service.address.street + " " + service.address.neighborhood)
                        .foregroundColor(.gray)
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .lineLimit(1)
                    //TODO: Trocar pra calcular a distancia do usuario pro local em km
                    Text(service.address.city)
                        .foregroundColor(.gray)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .lineLimit(1)
                }
                .padding()
                
            }
    }
}

#Preview {
    ListComponent()
}
