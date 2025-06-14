//
//  TransformadasApp.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftUI
import SwiftData

@main
struct TransformadasApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Effect.self,
            User.self,
            Entry.self,
            Reminder.self,
            NotificationModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
       
        WindowGroup {
            SplashScreen()
        }
        .modelContainer(sharedModelContainer)
    }
    
}
