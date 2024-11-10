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
            predicate: #Predicate{$0.modelID == ID}
        )
        
        let reminders = try context.fetch(request)
        guard let reminder = reminders.first else {
            throw ModelError.notFound
        }
        
        return reminder
        
    }
    
    func editReminder(reminder: Reminder) throws {
        var foundReminder = try getReminder(ID: reminder.modelID)
        
        foundReminder.name = reminder.name
        foundReminder.startDate = reminder.startDate
        foundReminder.repetition = reminder.repetition
        foundReminder.type = reminder.type
        foundReminder.daysOfTheWeek = reminder.daysOfTheWeek
        foundReminder.time = reminder.time
        foundReminder.daysCompleted = reminder.daysCompleted
        foundReminder.notes = reminder.notes
        foundReminder.dosage = reminder.dosage
        
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

func copyReminder(toReminder: Reminder, reminder: Reminder) {
    toReminder.name = reminder.name
    toReminder.startDate = reminder.startDate
    toReminder.repetition = reminder.repetition
    toReminder.type = reminder.type
    toReminder.daysOfTheWeek = reminder.daysOfTheWeek
    toReminder.time = reminder.time
    toReminder.daysCompleted = reminder.daysCompleted
    toReminder.notes = reminder.notes
    toReminder.dosage = reminder.dosage
}

func hadChangesOnReminder(oldReminder: Reminder, newReminder: Reminder) -> Bool {
    return oldReminder.name != newReminder.name ||
    oldReminder.startDate != newReminder.startDate ||
    oldReminder.repetition != newReminder.repetition ||
    oldReminder.type != newReminder.type ||
    oldReminder.time != newReminder.time ||
    oldReminder.daysCompleted != newReminder.daysCompleted ||
    oldReminder.notes != newReminder.notes ||
    oldReminder.dosage != newReminder.dosage
}
