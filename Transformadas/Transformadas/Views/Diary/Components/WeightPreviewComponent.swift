//
//  WeightPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct WeightPreviewComponent: View {
    var weight: Double
    var isPreview: Bool
    
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
                    .font(.system(size: isPreview ? 15 : 18, weight: .medium))
                    .foregroundStyle(.cinzaEscuro)
            }.foregroundStyle(.white)
            
            Spacer()
            
        }.padding(8)
        .background{
            RoundedRectangle(cornerRadius: 8).fill(.cinzaMuitoClaro)
        }
        
    }
}

#Preview {
    WeightPreviewComponent(weight: 63.7, isPreview: false)
}
