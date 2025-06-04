//
//  EffectEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

enum EffectEnum: Codable, CaseIterable {
    case fadiga
    case acne
    case insonia
    case sudorese
    case aumentoDaLibido
    case dorNasArticulacoes
    case crescimentoPelos
    case vozGrave
    case massaMuscular
    case redistribuicaoGordura
    case reducaoDaLibido
    case diminuicaoPelos
    case crescimentoDasMamas
    
    var type: HormonalTherapyType {
        switch self {
        case .fadiga: return .ratherNotInform
        case .acne: return .ratherNotInform
        case .insonia: return .ratherNotInform
        case .sudorese: return .ratherNotInform
        case .aumentoDaLibido: return .masculization
        case .dorNasArticulacoes: return .ratherNotInform
        case .crescimentoPelos: return .masculization
        case .vozGrave: return .masculization
        case .massaMuscular: return .masculization
        case .redistribuicaoGordura: return .ratherNotInform
        case .reducaoDaLibido: return .feminization
        case .diminuicaoPelos: return .feminization
        case .crescimentoDasMamas: return .feminization
        }
    }
    
    var effect: Effect {
        switch self {
        case .fadiga: return Effect(name: "Fadiga", status: .active)
        case .acne: return Effect(name: "Acne", status: .active)
        case .insonia: return Effect(name: "Insônia", status: .active)
        case .sudorese: return Effect(name: "Sudorese", status: .active)
        case .aumentoDaLibido: return Effect(name: "Aumento da Libido", status: .active)
        case .dorNasArticulacoes: return Effect(name: "Dor nas Articulações", status: .active)
        case .crescimentoPelos: return Effect(name: "Crescimento de pelos", status: .active)
        case .vozGrave: return Effect(name: "Voz mais grave", status: .active)
        case .massaMuscular: return Effect(name: "Aumento da Massa Muscular", status: .active)
        case .redistribuicaoGordura: return Effect(name: "Redistribuição da Gordura Corporal", status: .active)
        case .reducaoDaLibido: return Effect(name: "Redução da Libido", status: .active)
        case .diminuicaoPelos: return Effect(name: "Diminuição de Pelos", status: .active)
        case .crescimentoDasMamas: return Effect(name: "Crescimento das Mamas", status: .active)
        }
    }
}
