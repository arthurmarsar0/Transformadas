//
//  Reminder.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftData
import Foundation

@Model
class Reminder: Identifiable, Hashable {
    var name: String = ""
    var modelID: UUID = UUID()
    var startDate: Date = Date.distantPast
    var repetition: Repetition = Repetition.never
    var type: ReminderType = ReminderType.event
    var daysOfTheWeek: [Bool] = Array(repeating: false, count: 7)
    var time: Date = Date.now
    var daysCompleted: [Date] = []
    var notes: String = ""
    var dosage: String = ""
    @Relationship(deleteRule: .nullify, inverse: .none) var notifications: [NotificationModel]?
    
    init(name: String, startDate: Date, repetition: Repetition, type: ReminderType, daysOfTheWeek: [Bool], time: Date, daysCompleted: [Date], notes: String, dosage: String) {
        self.name = name
        self.startDate = startDate
        self.repetition = repetition
        self.type = type
        self.daysOfTheWeek = daysOfTheWeek
        self.time = time
        self.daysCompleted = daysCompleted
        self.notes = notes
        self.dosage = dosage
    }
    
    init(name: String, startDate: Date, repetition: Repetition, type: ReminderType, time: Date, daysCompleted: [Date], notes: String, dosage: String) {
        self.name = name
        self.startDate = startDate
        self.repetition = repetition
        self.type = type
        self.time = time
        self.daysCompleted = daysCompleted
        self.notes = notes
        self.dosage = dosage
    }
}
