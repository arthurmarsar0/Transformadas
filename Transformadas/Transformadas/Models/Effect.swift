//
//  Effect.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData

@Model
class Effect: Identifiable {
    var modelID: UUID = UUID()
    var name: String = ""
    
    init(name: String) {
        self.name = name
    }
}

extension Effect: Comparable {
    static func < (lhs: Effect, rhs: Effect) -> Bool {
        lhs.modelID < rhs.modelID
    }
    
    static func > (lhs: Effect, rhs: Effect) -> Bool {
        lhs.modelID > rhs.modelID
    }
    
    static func == (lhs: Effect, rhs: Effect) -> Bool {
        lhs.modelID == rhs.modelID
    }
}

enum EffectEnum: Codable, CaseIterable {
    case insomnia
    case fatigue
    
    var effect: Effect {
        switch self {
            case .insomnia: return Effect(name: "Insônia")
            case .fatigue: return Effect(name: "Fadiga")
        }
    }
}
