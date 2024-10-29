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
                
            }.navigationTitle("Diário")
            .toolbar {
                Button(action: {
                    
                }) {
                    Image(systemName: "plus")
                }

                Button(action: {
                    
                }) {
                    Image(systemName: "calendar")
                }
                
                Button(action: {
                    
                }) {
                    Image(systemName: "ellipsis.circle")
                }
            }
            Text("Hello, World!")
        }
        
    }
    
}

#Preview {
    Diary()
}
