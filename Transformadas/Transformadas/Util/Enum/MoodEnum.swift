//
//  MoodEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

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
      case .bad: return "😔"
      case .moreOrLess: return "😕"
      case .ok: return "😐"
      case .well: return "☺️"
      case .excellent: return "😀"
    }
  }
}
