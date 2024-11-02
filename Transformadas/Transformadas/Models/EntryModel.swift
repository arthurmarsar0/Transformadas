//
//  EntryModel.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData
import SwiftUI

class EntryModel {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    static func imageToData(image: UIImage) -> Data? {
        return image.jpegData(compressionQuality: 0.8)
    }
    
    static func dataToImage(data: Data) -> Image? {
        if let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        
        return nil
    }
    
    static func dataToImages(dataset: [Data]) -> [Image] {
        var images: [Image] = []
        
        for data in dataset {
            if let uiImage = UIImage(data: data) {
                images.append(Image(uiImage: uiImage))
            }
        }
        
        return images

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
        var oldEntry = try getEntry(date: entry.date)
        
        oldEntry.date = entry.date
        oldEntry.mood = entry.mood
        oldEntry.note = entry.note
        oldEntry.audio = entry.audio
        oldEntry.photos = entry.photos
        oldEntry.effects = entry.effects
        oldEntry.documents = entry.documents
        
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
