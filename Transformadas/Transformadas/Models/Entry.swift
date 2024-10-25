//
//  Entry.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftData
import SwiftUI

enum Mood {
    case bad
    case moreOrLess
    case ok
    case well
    case excellent
    
}

enum Effect {
    case headache
}

@Model
class Entry {
    var date: Date
    var mood: Mood
    var note: String
    var audio: String // MUDAR
    var photo: Image
    var effects: [Effect]
    var pdf: String // MUDAR
    
    init(date: Date, mood: Mood, note: String, audio: String, photo: Image, effects: [Effect], pdf: String) {
        self.date = date
        self.mood = mood
        self.note = note
        self.audio = audio
        self.photo = photo
        self.effects = effects
        self.pdf = pdf
    }
}
