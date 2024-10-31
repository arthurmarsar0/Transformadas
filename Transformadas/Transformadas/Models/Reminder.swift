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
    var name: String = ""
    var modelID: UUID = UUID()
    var startDate: Date = Date.distantPast
    var endDate: Date?
    var repetition: Repetition = RepetitionEnum.daily.repetition
    var time: Date = Date.now
    var daysCompleted: [Date] = []
    
    init(name: String, startDate: Date, endDate: Date?, repetition: Repetition, time: Date, daysCompleted: [Date]) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.repetition = repetition
        self.time = time
        self.daysCompleted = daysCompleted
    }
}
