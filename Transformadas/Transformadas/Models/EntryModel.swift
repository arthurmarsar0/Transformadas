//
//  EntryModel.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData

class EntryModel {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func getEntries() throws -> [Entry] {
        let request = FetchDescriptor<Entry>()
        return try context.fetch(request)
        
    }
    
    func getEntry(date: Date) throws -> Entry {
        let request = FetchDescriptor<Entry>(
            predicate: #Predicate{$0.date == date}
        )
        
        let entries = try context.fetch(request)
        guard let entry = entries.first else {
            throw ModelError.notFound
        }
        
        return entry
        
    }
    
    func editEntry(entry: Entry) throws {
        let oldEntry = try getEntry(date: entry.date)
        
        oldEntry.date = entry.date
        oldEntry.mood = entry.mood
        oldEntry.note = entry.note
        oldEntry.audio = entry.audio
        oldEntry.photo = entry.photo
        oldEntry.effects = entry.effects
        oldEntry.pdf = entry.pdf
        
        try context.save()
        
    }
    
    func addEntry(entry: Entry) throws {
        context.insert(entry)
        try context.save()
    }
    
    func deleteEntry(entry: Entry) throws {
        context.delete(entry)
        try context.save()
    }
    
    
}
