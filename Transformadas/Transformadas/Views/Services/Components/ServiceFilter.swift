//
//  ServiceFilter.swift
//  Transformadas
//
//  Created by Alice Barbosa on 05/11/24.
//

import SwiftUI

struct ServiceFilter: View {
    var body: some View {
        ZStack (alignment: .leading){
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 36)
                .foregroundStyle(.cinzaMuitoClaro)
            HStack{
                Image(systemName: "magnifyingglass")
                    .padding()
                
                Text("Buscar")
            }
        }
        //.padding()
    }
}

#Preview {
    ServiceFilter()
}
