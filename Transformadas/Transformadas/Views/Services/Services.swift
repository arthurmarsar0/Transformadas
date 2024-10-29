//
//  Services.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI

struct Services: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("")
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading){
                    Text("Serviços")
                        .font(.system(size: 28, weight: .semibold))
                    
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
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
            Text("Hello, World!")
        }
        
    }
    
}

#Preview {
    Services()
}
