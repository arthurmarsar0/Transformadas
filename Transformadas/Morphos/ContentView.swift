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
    @StateObject var appData: AppData = AppData()
    @Query var effects: [Effect]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        if !appData.primeiraAbertura {
            Onboarding().environmentObject(appData)
        } else {
            TabView (selection: $selectedTab){
                Group {
                    Journey()
                        .environmentObject(appData)
                        .tabItem {
                        Label("Jornada", systemImage: "point.bottomleft.forward.to.point.topright.filled.scurvepath")
                    }
                    .tag(0)
                    Diary()
                        .environmentObject(appData)
                        .tabItem {
                        Label("Hoje", systemImage: "calendar")
                    }
                    
                    .tag(1)
                    Services()
                        .environmentObject(appData)
                        .tabItem {
                        Label("Serviços", systemImage: "network")
                    }.tag(2)
                    
                }
            }
            
            .toolbarBackgroundVisibility(.visible, for: .tabBar)
            .toolbarBackground(.bege, for: .tabBar)
            .onAppear {
                requestNotificationAccess { _ in
                    
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
