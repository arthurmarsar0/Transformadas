//
//  Reminder.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 25/10/24.
//

import SwiftData
import Foundation

enum Repetition {
    case daily
}

class Reminder {
    var ID: String
    var startDate: Date
    var endDate: Date?
    var repetition: Repetition
    var time: Date
    var daysCompleted: [Date]
    
    init(ID: String, startDate: Date, endDate: Date? = nil, repetition: Repetition, time: Date, daysCompleted: [Date]) {
        self.ID = ID
        self.startDate = startDate
        self.endDate = endDate
        self.repetition = repetition
        self.time = time
        self.daysCompleted = daysCompleted
    }
}
