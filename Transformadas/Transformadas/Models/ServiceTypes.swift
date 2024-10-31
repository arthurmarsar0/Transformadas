//
//  ServiceTypes.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 27/10/24.
//

import Foundation
import MapKit

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



extension CLLocationCoordinate2D {
    
    func coordinateToList() -> [Double] {
        return [self.latitude, self.longitude]
    }
    
    static func listToCoordinate(list: [Double]) -> CLLocationCoordinate2D {
        let latitude = list[0]
        let longitude = list[1]
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}


