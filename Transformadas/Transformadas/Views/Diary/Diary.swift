//
//  Diary.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 29/10/24.
//

import SwiftUI
import SwiftData

struct Diary: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("")
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading){
                    Text("Diário")
                        .font(.system(size: 28, weight: .semibold))
                    
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                    }
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
                        
                    }
                }
            }
            Text("Hello, World!")
        }
        
    }
    
}

#Preview {
    Diary()
}
