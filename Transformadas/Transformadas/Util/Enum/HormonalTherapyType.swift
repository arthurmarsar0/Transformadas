//
//  HormonalTherapyType.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

enum HormonalTherapyType: Codable, CaseIterable {
    case feminization
    case masculization
    case noHormonalTherapy
    case ratherNotInform
    
    var displayName: String {
        switch self {
        case .feminization:
            return "Feminizante"
        case .masculization:
            return "Masculinizante"
        case .noHormonalTherapy:
            return "Não faço"
        case .ratherNotInform:
            return "Prefiro não informar"
            
        }
    }
}
