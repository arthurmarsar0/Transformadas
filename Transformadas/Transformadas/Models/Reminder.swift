//
//  Reminder.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftData
import Foundation

@Model
class Reminder {
    var modelID: UUID = UUID()
    var startDate: Date?
    var endDate: Date?
    var repetition: Repetition?
    var time: Date?
    var daysCompleted: [Date]?
    
    init(startDate: Date?, endDate: Date? = nil, repetition: Repetition?, time: Date?, daysCompleted: [Date]?) {
        self.startDate = startDate
        self.endDate = endDate
        self.repetition = repetition
        self.time = time
        self.daysCompleted = daysCompleted
    }
}
