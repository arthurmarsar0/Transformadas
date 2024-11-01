//
//  SheetDetailView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 31/10/24.
//

import SwiftUI

struct SheetDetailView: View {
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
        ZStack{
            Color.bege.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16){
                
                VStack(alignment: .leading){
                    HStack {
                        ForEach(service.categories , id: \.self) { category in
                            Image(systemName: category.symbol)
                                .foregroundStyle(.verde)
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
        }
    }
}

#Preview {
    SheetDetailView()
}
