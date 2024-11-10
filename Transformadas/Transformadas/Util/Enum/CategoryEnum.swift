//
//  CategoryEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

import Foundation
import SwiftUICore


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

    var symbol: String{
        switch self{
        case .all: return ""
        case .medical: return "cross.fill"
        case .psychological: return "brain.fill"
        case .judicial: return "list.clipboard.fill"
        case .protection: return "light.beacon.min.fill"
        case .social: return "person.2.fill"
        }
    }
    
    var color: Color{
        switch self{
        case .all: return .verde
        case .medical: return .rosa
        case .psychological: return .verde
        case .judicial: return .rosaMedio
        case .protection: return .vermelho
        case .social: return .verdeMedio
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
