//
//  Journey.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI

struct Journey: View {
    @State var isUserInfoPresented: Bool = false
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
                        isUserInfoPresented.toggle()
                    }) {
                        Image(systemName: "ellipsis.circle")
                            .foregroundStyle(.black)
                    }
                }
            }
            .sheet(isPresented: $isUserInfoPresented) {
                UserInfoSheetView()
            }
            Text("Hello, World!")
        }
        
    }
    
}

#Preview {
    Journey()
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
