//
//  Address.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

struct Address: Codable {
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
