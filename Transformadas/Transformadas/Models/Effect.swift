//
//  Effect.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData

@Model
class Effect: Identifiable {
    var modelID: UUID = UUID()
    var name: String = ""
    var status: EffectStatus = EffectStatus.active
    @Relationship(deleteRule: .nullify, inverse: \Entry.effects) var entries: [Entry]?
    
    init(name: String, status: EffectStatus) {
        self.name = name
        self.status = status
    }
    
    init(name: String) {
        self.name = name
        self.status = .active
    }
}

extension Effect: Comparable {
    static func < (lhs: Effect, rhs: Effect) -> Bool {
        lhs.modelID < rhs.modelID
    }
    
    static func > (lhs: Effect, rhs: Effect) -> Bool {
        lhs.modelID > rhs.modelID
    }
    
    static func == (lhs: Effect, rhs: Effect) -> Bool {
        lhs.modelID == rhs.modelID
    }
}
