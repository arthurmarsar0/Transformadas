//
//  Entry.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData
import SwiftUI

enum Mood: Codable {
    case bad
    case moreOrLess
    case ok
    case well
    case excellent
    
    var name: String {
        switch self {
            case .bad: return "Mal"
            case .moreOrLess: return "Mais ou menos"
            case .ok: return "Ok"
            case .well: return "Bem"
            case .excellent: return "Excelente"
        }
    }

}

@Model
class Entry {
    var date: Date?
    var mood: Mood?
    var note: String?
    var audio: String? // MUDAR
    var photo: String? // MUDAR
    @Relationship var effects: [Effect]?
    var pdf: String? // MUDAR
    
    init(date: Date?, mood: Mood?, note: String?, audio: String?, photo: String?, effects: [Effect]?, pdf: String?) {
        self.date = date
        self.mood = mood
        self.note = note
        self.audio = audio
        self.photo = photo
        self.effects = effects
        self.pdf = pdf
    }
}
