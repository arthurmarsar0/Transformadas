//
//  User.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData

enum HormonalTherapyType: Codable {
    case feminization
    case masculization
}

enum UserPronoun: Codable {
    case eleDele
    case elaDela
    case eluDelu
}

@Model
class User {
    
    var modelID: UUID = UUID()
    var name: String = ""
    var weight: Double?
    var transitionStart: Date?
    var hormonalTherapyType: HormonalTherapyType = HormonalTherapyType.feminization
    var pronouns: [UserPronoun] = []
    
    init(name: String, weight: Double?, transitionStart: Date?, hormonalTherapyType: HormonalTherapyType, pronouns: [UserPronoun]) {
        self.name = name
        self.weight = weight
        self.transitionStart = transitionStart
        self.hormonalTherapyType = hormonalTherapyType
        self.pronouns = pronouns
    }
    
}

