//
//  RepetitionEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

enum RepetitionEnum: Codable, CaseIterable {
    case never
    case daily
    case weekly
    case monthly
    case trimestral
    case semestral
    case annual
    
    var frequency: Int {
        switch self {
            case .never: return 0
            case .daily: return 1
            case .weekly: return 7
            case .monthly: return 30
            case .trimestral: return 90
            case .semestral: return 180
            case .annual: return 365
            
        }
    }
    
    var repetition: Repetition {
        return Repetition(frequency: self.frequency)
    }
    
    var name: String {
        switch self {
            case .never: return "Nunca"
            case .daily: return "Todos os Dias"
            case .weekly: return "Semanalmente"
            case .monthly: return "Mensalmente"
            case .trimestral: return "Trimestralmente"
            case .semestral: return "Semestralmente"
            case .annual: return "Anualmente"
        }
    }
    
    static func toEnum(repetition: Repetition) -> RepetitionEnum? {
       
        for rep in RepetitionEnum.allCases {
            if rep.frequency == repetition.frequency {
                return rep
            }
        }
        
        return nil
    }
}
