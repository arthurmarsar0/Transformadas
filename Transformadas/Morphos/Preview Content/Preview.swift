//
//  Preview.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

import Foundation
import SwiftData

struct Preview {
    
    let modelContainer: ModelContainer
    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            modelContainer = try ModelContainer(for:
                Effect.self,
                User.self,
                Entry.self,
                Reminder.self, configurations: config)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    func addEntriesExamples(_ examples: [Entry]) {
            
        Task { @MainActor in
            examples.forEach { example in
                modelContainer.mainContext.insert(example)
            }
        }
        
    }
    
    func addRemindersExamples(_ examples: [Reminder]) {
            
        Task { @MainActor in
            examples.forEach { example in
                modelContainer.mainContext.insert(example)
            }
        }
        
    }
    
    func addEffectsExamples(_ examples: [Effect]) {
            
        Task { @MainActor in
            examples.forEach { example in
                modelContainer.mainContext.insert(example)
            }
        }
        
    }
    
}
