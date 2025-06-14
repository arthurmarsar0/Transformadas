//
//  Service.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import CloudKit

class Service :  Identifiable{
    var id: String
    var ID: String?
    var name: String
    var categories: [Category]
    var email: String
    var telephone: String
    var description: String
    var address: Address
    var coordinate: CLLocationCoordinate2D
    
    init(id: String = UUID().uuidString, name: String, categories: [Category], email: String, telephone: String, description: String, address: Address, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.categories = categories
        self.email = email
        self.telephone = telephone
        self.description = description
        self.address = address
        self.coordinate = coordinate
    }
    
}
