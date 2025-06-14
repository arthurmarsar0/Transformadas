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
    var weekDayNumber: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var dayOfWeekString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var monthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    var hourFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var dayMonthYear: String {
        return "\(dayNumber)-\(monthNumber)-\(yearNumber)"
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

func isAfterDate(startDate: Date, date: Date) -> Bool {
    return date >= startDate || isSameDay(date, startDate)
}

func isFutureDate(_ date: Date) -> Bool {
    return date > Date.now && !isSameDay(date, Date.now)
}

func isSameDayAndMonth(_ date1: Date, _ date2: Date) -> Bool {
    let calendar = Calendar.current
    return date1.dayNumber == date2.dayNumber && date1.monthNumber == date2.monthNumber
}

extension TimeInterval {
    var minutesAndSeconds: String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//func getDaysPassed(_ date1: Date, _ date2: Date) -> Int {
//
//}

extension Calendar {
    func numberOfDays(from startDate: Date, to endDate: Date) -> Int {
        let fromDate = startOfDay(for: startDate)
        let toDate = startOfDay(for: endDate)
        return dateComponents([.day], from: fromDate, to: toDate).day!
    }
}

func getDateByDayAndTime(day: Date, time: Date) -> Date? {
    var components = Calendar.current.dateComponents([.year, .month, .day], from: day)
    components.hour = Calendar.current.component(.hour, from: time)
    components.minute = Calendar.current.component(.minute, from: time)
    
    
    return Calendar.current.date(from: components)
}
