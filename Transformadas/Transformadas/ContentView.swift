//
//  ContentView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var tabViewModel: TabViewModel = TabViewModel()
    @StateObject var audioPlayer: AudioPlayer = AudioPlayer()
    @StateObject var appData: AppData = AppData()
    @Query var effects: [Effect]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        if !appData.primeiraAbertura {
            Onboarding().environmentObject(appData)
        } else {
            TabView (selection: $tabViewModel.selectedTab){
                Group {
                    Journey()
                        .environmentObject(appData)
                        .environmentObject(tabViewModel)
                        .environmentObject(audioPlayer)
                        .tabItem {
                        Label("Jornada", systemImage: "point.bottomleft.forward.to.point.topright.filled.scurvepath")
                    }
                    .tag(0)
                    Diary()
                        .environmentObject(appData)
                        .environmentObject(tabViewModel)
                        .environmentObject(audioPlayer)
                        .tabItem {
                        Label("Hoje", systemImage: "calendar")
                    }
                    
                    .tag(1)
                    Services()
                        .environmentObject(appData)
                        .environmentObject(tabViewModel)
                        .environmentObject(audioPlayer)
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

class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 1
    @Published var isShowingEntrySheet: Bool = false
    @Published var selectedDate: Date = Date.now
}

#Preview {
    ContentView()
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
