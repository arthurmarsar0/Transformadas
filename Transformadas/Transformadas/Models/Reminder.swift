//
//  Reminder.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftData
import Foundation

@Model
class Reminder: Identifiable {
    var name: String = ""
    var modelID: UUID = UUID()
    var startDate: Date = Date.distantPast
    var endDate: Date?
    var repetition: Repetition = RepetitionEnum.never.repetition
    var type: ReminderType = ReminderType.event
    var time: Date = Date.now
    var daysCompleted: [Date] = []
    var notes: String = ""
    var dosage: String = ""
    
    init(name: String, startDate: Date, endDate: Date?, repetition: Repetition, type: ReminderType, time: Date, daysCompleted: [Date], notes: String, dosage: String) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.repetition = repetition
        self.type = type
        self.time = time
        self.daysCompleted = daysCompleted
        self.notes = notes
        self.dosage = dosage
    }
}
