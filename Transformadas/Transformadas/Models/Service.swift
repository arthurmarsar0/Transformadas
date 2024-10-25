//
//  Service.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftData
import Foundation

enum Category {
    case all
    case medical
    case psychological
    case judicial
    case protection
    case social
}

struct Address {
    var city: String
    var street: String
    var neighborhood: String
}

struct Coordinate {
    var latitude: Double
    var longitude: Double
}

class Service {
    var ID: String
    var name: String
    var categories: [Category]
    var email: String
    var telephone: String
    var description: String
    var address: Address
    var coordinate: Coordinate
    
    init(ID: String, name: String, categories: [Category], email: String, telephone: String, description: String, address: Address, coordinate: Coordinate) {
        self.ID = ID
        self.name = name
        self.categories = categories
        self.email = email
        self.telephone = telephone
        self.description = description
        self.address = address
        self.coordinate = coordinate
    }
    
}
