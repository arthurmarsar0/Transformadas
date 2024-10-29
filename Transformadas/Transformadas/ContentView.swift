//
//  ContentView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var selectedTab: Int = 1
    
    var body: some View {
        TabView (selection: $selectedTab){
            Group {
                Journey().tabItem {
                    Label("Check-in", systemImage: "person.fill")
                }
                .tag(0)
                Diary().tabItem {
                    Label("Venda", systemImage: "calendar")
                }
                
                .tag(1)
                Services().tabItem {
                    Label("Serviços", systemImage: "text.book.closed.fill")
                }.tag(2)
                
            }
        }.onAppear{
            //setupTabBarAppearance(modo: true)
        }
    }
    
}

#Preview {
    ContentView()
}
