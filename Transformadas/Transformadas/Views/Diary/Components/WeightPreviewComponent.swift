//
//  WeightPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct WeightPreviewComponent: View {
    var weight: Double
    var isReduced: Bool
    
    var body: some View {
        HStack (spacing: 12) {
            Image(systemName: "scalemass.fill")
                .font(.system(size: 32))
                .foregroundStyle(.verdeMedio)
            VStack (alignment: .leading){
                Text("Peso")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundStyle(.cinzaClaro)
                Text(String(format: "%.1f kg", weight))
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.cinzaEscuro)
            }.foregroundStyle(.white)
            if !isReduced {
                Spacer()
            }
        }.padding(8)
        .background{
            RoundedRectangle(cornerRadius: 8).fill(.cinzaMuitoClaro)
        }.frame(maxWidth: isReduced ? 164.5 : 337)
    }
}

#Preview {
    WeightPreviewComponent(weight: 63.7, isReduced: false)
}
