//
//  EffectEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

enum EffectEnum: Codable {
    case insomnia
    
    var effect: Effect {
        switch self {
            case .insomnia: return Effect(name: "Insônia")
        }
    }
}
