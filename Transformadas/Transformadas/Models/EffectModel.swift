//
//  EffectModel.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData

class EffectModel {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func getEffects() throws -> [Effect] {
        let request = FetchDescriptor<Effect>()
        return try context.fetch(request)
        
    }
    
    func getEffect(ID: UUID) throws -> Effect {
        let request = FetchDescriptor<Effect>(
            predicate: #Predicate{$0.ID == ID}
        )
        
        let effects = try context.fetch(request)
        guard let effect = effects.first else {
            throw ModelError.notFound
        }
        
        return effect
    }
    
    func editEffect(effect: Effect) throws {
        var oldEffect = try getEffect(ID: effect.ID)
        
        oldEffect.name = effect.name
        
        try context.save()
        
    }
    
    func addEffect(effect: Effect) throws {
        context.insert(effect)
        try context.save()
    }
    
    func deleteEffect(effect: Effect) throws {
        context.delete(effect)
        try context.save()
    }
}
