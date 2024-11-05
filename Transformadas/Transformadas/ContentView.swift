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
    }
    
}

#Preview {
    let preview = Preview()
    preview.addEntriesExamples(EntryModel.samples)
    preview.addEffectsExamples(EffectModel.samples)
    preview.addRemindersExamples(ReminderModel.samples)
    return ContentView()
            .modelContainer(preview.modelContainer)
}
