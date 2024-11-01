//
//  ContentView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
<<<<<<< HEAD
    @State var showSheet: Bool = false
    
    var body: some View {
        RegisterSheet(isPresented: $showSheet)
=======
    @State var selectedTab: Int = 1
    
    var body: some View {
        TabView (selection: $selectedTab){
            Group {
                Journey().tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
                .tag(0)
                Diary().tabItem {
                    Label("Diário", systemImage: "calendar")
                }
                
                .tag(1)
                Services().tabItem {
                    Label("Serviços", systemImage: "text.book.closed.fill")
                }.tag(2)
                
            }
        }.onAppear{
            //setupTabBarAppearance(modo: true)
        }
>>>>>>> dev
    }
    
}

#Preview {
    ContentView().modelContainer(for: [Effect.self])
}
