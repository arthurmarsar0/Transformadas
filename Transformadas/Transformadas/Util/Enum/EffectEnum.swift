//
//  EffectEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

enum EffectEnum: Codable, CaseIterable {
    case insonia
    case fadiga
    case acne
    case sudorese
    case reducaoDaLibido
    case crescimentoDasMamas
    
    var effect: Effect {
        switch self {
        case .insonia: return Effect(name: "Insônia", status: .active)
        case .fadiga: return Effect(name: "Fadiga", status: .active)
        case .acne: return Effect(name: "Acne", status: .active)
        case .sudorese: return Effect(name: "Sudorese", status: .active)
        case .reducaoDaLibido: return Effect(name: "Redução da Libido", status: .active)
        case .crescimentoDasMamas: return Effect(name: "Crescimento das mamas", status: .active)
        }
    }
}
