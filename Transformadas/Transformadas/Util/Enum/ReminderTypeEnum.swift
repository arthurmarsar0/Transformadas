//
//  ReminderTypeEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

enum ReminderType: Codable, CaseIterable {
    case event
    case medicine
    
    var name: String {
        switch self {
        case .event: return "Evento"
        case .medicine: return "Medicamento"
        }
    }
}
