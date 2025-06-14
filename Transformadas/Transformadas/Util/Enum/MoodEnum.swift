//
//  MoodEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

enum Mood: Int, Codable, CaseIterable {
    case excellent = 5
    case well = 4
    case ok = 3
    case moreOrLess = 2
    case bad = 1
    
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
      case .bad: return "😔"
      case .moreOrLess: return "😕"
      case .ok: return "😐"
      case .well: return "☺️"
      case .excellent: return "😀"
    }
  }
}
