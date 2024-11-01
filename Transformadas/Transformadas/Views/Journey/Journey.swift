//
//  Journey.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI

struct Journey: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("")
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading){
                    Text("Jornada")
                        .font(.system(size: 28, weight: .semibold))
                    
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                    }) {
                        Image(systemName: "calendar")
                            .foregroundStyle(.black)
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                    }) {
                        Image(systemName: "ellipsis.circle")
                            .foregroundStyle(.black)
                    }
                }
            }
            Text("Hello, World!")
        }
        
    }
    
}

#Preview {
    Journey()
}
