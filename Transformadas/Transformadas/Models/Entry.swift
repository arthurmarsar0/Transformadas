//
//  Entry.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData
import SwiftUI

enum Mood: Codable, CaseIterable {
  case excellent
  case well
  case ok
  case moreOrLess
  case bad
  var name: String {
    switch self {
      case .bad: return "Mal"
      case .moreOrLess: return "Mais ou menos"
      case .ok: return "Ok"
      case .well: return "Bem"
      case .excellent: return "Excelente"
    }
  }
  var emoji: String {
    switch self {
      case .bad: return ":arrependido:"
      case .moreOrLess: return ":confuso:"
      case .ok: return ":expressão_neutra:"
      case .well: return ":feliz:"
      case .excellent: return ":rindo:"
    }
  }
}

@Model
class Entry {
    var date: Date = Date.now
    var mood: Mood?
    var note: String?
    var audio: String? // MUDAR
    var photos: [Data] = [] // MUDAR
    @Relationship var effects: [Effect]?
    var documents: [String]? // MUDAR
    var weight: Double?
    
    init(date: Date, mood: Mood?, note: String?, audio: String?, photos: [Data], effects: [Effect]?, documents: [String]?, weight: Double?) {
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
