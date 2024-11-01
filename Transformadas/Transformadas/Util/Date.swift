//
//  Date.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import Foundation

extension Date {
    
    var dayNumber: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var monthNumber: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var yearNumber: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var dayOfWeekString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var monthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    var hourFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}

func datesInCurrentMonth() -> [Date] {
    var dates: [Date] = []
    let today = Date.now

    guard let range = Calendar.current.range(of: .day, in: .month, for: today),
          let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: today)) else {
        return dates
    }
  
    for day in range {
        if let date = Calendar.current.date(byAdding: .day, value: day - 1, to: startOfMonth) {
            dates.append(date)
        }
    }
    
    return dates
}

func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDate(date1, equalTo: date2, toGranularity: .day)
}

func isFutureDate(_ date: Date) -> Bool {
    return date > Date.now
}
