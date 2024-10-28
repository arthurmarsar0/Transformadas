//
//  ReminderModel.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import Foundation
import SwiftData

class ReminderModel {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func getReminders() throws -> [Reminder] {
        let request = FetchDescriptor<Reminder>()
        return try context.fetch(request)
        
    }
    
    func getReminder(ID: UUID) throws -> Reminder {
        let request = FetchDescriptor<Reminder>(
            predicate: #Predicate{$0.ID == ID}
        )
        
        let reminders = try context.fetch(request)
        guard let reminder = reminders.first else {
            throw ModelError.notFound
        }
        
        return reminder
        
    }
    
    func editReminder(reminder: Reminder) throws {
        var oldReminder = try getReminder(ID: reminder.ID)
        
        oldReminder.startDate = reminder.startDate
        oldReminder.endDate = reminder.endDate
        oldReminder.repetition = reminder.repetition
        oldReminder.time = reminder.time
        oldReminder.daysCompleted = reminder.daysCompleted
        
        try context.save()
        
    }
    
    func addReminder(reminder: Reminder) throws {
        context.insert(reminder)
        try context.save()
    }
    
    func deleteReminder(reminder: Reminder) throws {
        context.delete(reminder)
        try context.save()
    }
    
    
}
