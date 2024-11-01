//
//  Diary.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 29/10/24.
//

import SwiftUI
import SwiftData

struct Diary: View {
    @State var showSheet: Bool = false
    
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
            Button(action: {
                showSheet.toggle()
            }, label:{
                Text("Abrir sheet registro")
            }
            )
        }
        .sheet(isPresented: $showSheet, content: {
            RegisterSheet(isPresented: $showSheet)
        })
        
    }
    
}

#Preview {
    Diary()
}
