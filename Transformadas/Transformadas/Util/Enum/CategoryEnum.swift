//
//  CategoryEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

enum Category: Codable, CaseIterable {
    case all
    case medical
    case psychological
    case judicial
    case protection
    case social
    
    var name: String {
        switch self {
        case .all: return "Todos"
        case .medical: return "Médicos"
        case .psychological: return "Psicológicos"
        case .judicial: return "Jurídicos"
        case .protection: return "Proteção"
        case .social: return "Sociais"
        }
    }
    
    static func nameToCategory(name: String) -> Category {
        for category in Category.allCases {
            if name == category.name {
                return category
            }
        }
        
        return .all
        
    }
}
