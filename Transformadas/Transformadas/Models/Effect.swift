//
//  Effect.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData

@Model
class Effect {
    var modelID: UUID = UUID()
    var name: String = ""
    
    init(name: String) {
        self.name = name
    }
}

enum EffectEnum: Codable {
    case insomnia
    
    var effect: Effect {
        switch self {
            case .insomnia: return Effect(name: "Insônia")
        }
    }
}
