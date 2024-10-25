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
    
    func getEntries() -> [Entry] {
        let request = FetchDescriptor<Entry>()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Erro ao obter registros: \(error)")
            return []
        }
    }
    
    func saveEntry(entry: Entry) {
        context.insert(entry)
    }
    
    func deleteEntry(entry: Entry) {
        context.delete(entry)
    }
    
    
}
