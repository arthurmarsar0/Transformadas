//
//  ListComponent.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI

struct ListComponent: View {
    var symbols: [String] = ["person.2.fill", "cross.fill"]
    var title: String = "Policlínica lessa de andradeeeeeeeeeeeeeeeeeeeeeee"
    var adress: String = "Estrada dos remédios, 2416, Recife"
    var distance: String = "15,5 km"
    
    var body: some View {
        ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 8)
                .frame(width: .infinity, height: 128)
                .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        ForEach(symbols, id: \.self) { symbol in
                            Image(systemName: symbol)
                                .foregroundStyle(.gray)
                        }
                    }
                    Text(title)
                        .foregroundColor(.gray)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .lineLimit(1)
                        
                    Text(adress)
                        .foregroundColor(.gray)
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .lineLimit(1)
                    
                    Text(distance)
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
