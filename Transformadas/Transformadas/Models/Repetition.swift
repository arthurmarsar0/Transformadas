//
//  Repetition.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 27/10/24.
//

import Foundation

enum RepetitionEnum: Codable {
    case never
    case daily
    
    var repetition: Repetition {
        switch self {
            case .never: return Repetition(frequency: 0)
            case .daily: return Repetition(frequency: 1)
        }
    }
}

struct Repetition: Codable {
    var frequency: Int
    
}
