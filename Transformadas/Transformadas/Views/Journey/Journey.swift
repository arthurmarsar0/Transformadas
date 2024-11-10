//
//  Journey.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI

struct Journey: View {
    @State var isUserInfoPresented: Bool = false
    @EnvironmentObject var appData: AppData
    
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
                        isUserInfoPresented.toggle()
                    }) {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
            .sheet(isPresented: $isUserInfoPresented, onDismiss: {
                addNavBarBackground()
            }) {
                UserInfoSheetView()
                    .environmentObject(appData)
                    .interactiveDismissDisabled()
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
