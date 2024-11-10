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
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        if !appData.primeiraAbertura {
            Onboarding().environmentObject(appData)
                .onAppear {
                    for effect in EffectEnum.allCases {
                        modelContext.insert(effect.effect)
                    }
                }
        } else {
            TabView (selection: $selectedTab){
                Group {
                    Journey().tabItem {
                        Label("Jornada", systemImage: "point.bottomleft.forward.to.point.topright.filled.scurvepath")
                    }
                    .tag(0)
                    Diary().tabItem {
                        Label("Hoje", systemImage: "calendar")
                    }
                    
                    .tag(1)
                    Services().tabItem {
                        Label("Serviços", systemImage: "network")
                    }.tag(2)
                    
                }
            }.onAppear{
                //setupTabBarAppearance(modo: true)
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
