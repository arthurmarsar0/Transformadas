//
//  Entry.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Entry: Identifiable, Hashable, Equatable {
    var date: Date = Date.now
    var mood: Mood?
    var note: String = ""
    var audio: Audio?
    var photos: [Data] = []
    @Relationship(deleteRule: .nullify, inverse: .none) var effects: [Effect]?
    var documents: [Document] = []
    var weight: Double?
    
    init(date: Date, mood: Mood?, note: String, audio: Audio?, photos: [Data], effects: [Effect]?, documents: [Document], weight: Double?) {
        self.date = date
        self.mood = mood
        self.note = note
        self.audio = audio
        self.photos = photos
        self.effects = effects
        self.documents = documents
        self.weight = weight
    }
    
    // MARK: - Identifiable
    var id: Date {
        return date
    }

    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        // Usando modelID para gerar o hash único para a instância
        hasher.combine(date)
    }

    // MARK: - Equatable
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return isSameDay(lhs.date, rhs.date)
    }
}
