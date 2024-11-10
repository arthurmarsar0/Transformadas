//
//  HormonalTherapyType.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

enum HormonalTherapyType: Codable {
    case feminization
    case masculization
    case nohormonaltherapy
    case rathernotinform
}

extension HormonalTherapyType {
    static var allTypes: [HormonalTherapyType] {
        return [.feminization, .masculization, .nohormonaltherapy, .rathernotinform]
    }

    var displayName: String {
        switch self {
        case .feminization:
            return "Feminizante"
        case .masculization:
            return "Masculinizante"
        case .nohormonaltherapy:
            return "Não faço"
        case .rathernotinform:
            return "Prefiro não informar"
            
        }
    }
}
