//
//  UserModel.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData

class UserModel {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func getUser(ID: UUID) throws -> User {
        let request = FetchDescriptor<User>(
            predicate: #Predicate{$0.modelID == ID}
        )
        
        let users = try context.fetch(request)
        guard let user = users.first else {
            throw ModelError.notFound
        }
        
        return user
        
    }
    
    func addUser(user: User) throws {
        context.insert(user)
        try context.save()
    }
    
    func editUser(user: User) throws {
        var oldUser = try getUser(ID: user.modelID)
        
        oldUser.name = user.name
        oldUser.weight = user.weight
        oldUser.transitionStart = user.transitionStart
        oldUser.hormonalTherapyType = user.hormonalTherapyType
        oldUser.pronouns = user.pronouns
        
        try context.save()
        
        
    }
    
    func deleteUser(user: User) throws {
        context.delete(user)
        try context.save()
    }
    
    
}
