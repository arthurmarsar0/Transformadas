//
//  User.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData

@Model
class User {
    var modelID: String?
    var name: String = ""
    var gender: String = ""
    var pronouns: String = ""
    var transitionStart: Date = Date.now
    var hormonalTherapyType: HormonalTherapyType = HormonalTherapyType.feminization
    
    init(modelID: String?, name: String, gender: String, transitionStart: Date, hormonalTherapyType: HormonalTherapyType, pronouns: String) {
        self.modelID = modelID
        self.name = name
        self.gender = gender
        self.transitionStart = transitionStart
        self.hormonalTherapyType = hormonalTherapyType
        self.pronouns = pronouns
    }
    
}

