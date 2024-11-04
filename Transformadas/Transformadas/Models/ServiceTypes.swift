//
//  ServiceTypes.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 27/10/24.
//

import Foundation
import SwiftUICore

enum Category: CaseIterable {
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

struct Address {
    var city: String
    var street: String
    var neighborhood: String
    
    func addressToList() -> [String] {
        return [city, street, neighborhood]
    }
    
    static func listToAddress(list: [String]) -> Address {
        let city = list[0]
        let street = list[1]
        let neighborhood = list[2]
        
        return Address(city: city, street: street, neighborhood: neighborhood)
    }
    
}



struct Coordinate {
    var latitude: Double
    var longitude: Double
    
    func coordinateToList() -> [Double] {
        return [latitude, longitude]
    }
    
    static func listToCoordinate(list: [Double]) -> Coordinate {
        let latitude = list[0]
        let longitude = list[1]
        
        return Coordinate(latitude: latitude, longitude: longitude)
    }
    
}


