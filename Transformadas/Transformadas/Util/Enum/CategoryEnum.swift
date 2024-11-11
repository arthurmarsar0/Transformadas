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
    
    var text: String{
        switch self{
        case .all: return ""
        case .medical: return "Cuidados como acompanhamento hormonal, procedimentos de afirmação de gênero, tratamentos preventivos entre outros serviços médicos."
        case .psychological: return "Atendimento psicológico com profissionais preparados e humanizados para lidar com pessoas trans,orientações e cuidados para lidar com a saúde mental."
        case .judicial: return "Auxilío no processo de retificação de nome e gênero, além de fornecer orientação sobre procedimentos legais e ajuda a assegurar direitos."
        case .protection: return "Apoio em situações de violência ou risco por meio de serviços de emergência, serviços dedicados a denúncias de crimes de LGBTQfobia e orientação sobre como buscar ajuda legal."
        case .social: return "Serviços de acolhimento, auxílio em questões de moradia e acesso a direitos básicos, serviços de inclusão como vagas afirmativas para empregos."
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
