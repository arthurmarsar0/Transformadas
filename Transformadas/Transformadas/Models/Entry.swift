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
class Entry {
    var date: Date = Date.now
    var mood: Mood?
    var note: String = ""
    var audio: Audio? // MUDAR
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
}
