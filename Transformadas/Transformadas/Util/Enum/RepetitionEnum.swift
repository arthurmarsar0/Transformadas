//
//  RepetitionEnum.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

import Foundation

enum Repetition: Codable, CaseIterable {
    case never
    case daily
    case weekly
    case daysOfTheWeek
    case biweekly
    case monthly
    case trimestral
    case semestral
    case annual
    
//    var frequency: Int {
//        switch self {
//            case .never: return 0
//            case .daily: return 1
//            case .weekly: return 7
//            case .daysOfTheWeek
//            case .monthly: return 30
//            case .trimestral: return 90
//            case .semestral: return 180
//            case .annual: return 365
//            
//        }
//    }
    
//    var repetition: Repetition {
//        return Repetition(frequency: self.frequency)
//    }
    
    var name: String {
        switch self {
            case .never: return "Nunca"
            case .daily: return "Todos os Dias"
            case .weekly: return "Semanalmente"
            case .monthly: return "Mensalmente"
            case .biweekly: return "Quinzenalmente"
            case .daysOfTheWeek: return "Dias da Semana"
            case .trimestral: return "Trimestralmente"
            case .semestral: return "Semestralmente"
            case .annual: return "Anualmente"
        }
    }
    
    func descriptionMessage(startDate: Date, selectedWeekDays: [Bool]) -> String {
        var days: [String] = []
        for day in WeekDay.allCases {
            if selectedWeekDays[day.rawValue - 1] {
                days.append(day.name)
            }
        }
        
        var daysPhrase: String = ""
        
        for i in 0..<days.count {
            if days.count > 1 && i == days.count - 1 {
                daysPhrase.append(" e ")
                daysPhrase.append(days[i])
            } else {
                daysPhrase.append(days[i])
                if i < days.count - 2 {
                    daysPhrase.append(", ")
                }
            }
            
        }
        
        var date: String = String("\(startDate.dayNumber) \(startDate.monthString.prefix(3).uppercased()) \(startDate.yearNumber)")
        
        switch self {
            case .never: return "O lembrete notificará apenas na data \(date)"
            
            case .daily: return "O lembrete notificará todos os dias a partir da data \(date)"
            case .daysOfTheWeek: return days.count == 0 ? "Selecione algum dia da semana" : "O lembrete notificará todo(a) \(daysPhrase)"
            
            case .weekly: return "O lembrete notificará todo(a) \(startDate.dayOfWeekString) a partir da data \(startDate.dayNumber) \(startDate.monthString) \(startDate.yearNumber)"
            case .biweekly: return "O lembrete notificará a cada 15 dias a partir da data \(startDate.dayNumber) \(startDate.monthString) \(startDate.yearNumber)"
            
            case .monthly: return "O lembrete notificará todo dia \(startDate.dayNumber) a partir da data \(date)"
            
            case .trimestral: return "O lembrete notificará a cada 3 meses no mesmo dia \(startDate.dayNumber) a partir da data \(date)"
            
            case .semestral: return "O lembrete notificará a cada 6 meses no mesmo dia \(startDate.dayNumber) a partir da data \(date)"
            
            case .annual: return "O lembrete notificará todo dia \(startDate.dayNumber) \(startDate.monthString) de cada ano"
        }
    }
    
    static func remindersToday(date: Date, reminders: [Reminder]) -> [Reminder] {
        reminders.filter { reminder in
            guard isAfterDate(startDate: reminder.startDate, date: date) else {
                return false
            }
            
            switch reminder.repetition {
            case .never:
                return isSameDay(reminder.startDate, date)
            case .daily:
                return true
            case .weekly:
                return date.weekDayNumber == reminder.startDate.weekDayNumber
            case .daysOfTheWeek:
                return reminder.daysOfTheWeek[date.weekDayNumber - 1]
            case .biweekly:
                if let difference = Calendar.current.dateComponents([.day], from: reminder.startDate, to: date).day {
                    return difference % 14 == 0
                }
                return false
            case .monthly:
                return date.dayNumber == reminder.startDate.dayNumber
            case .trimestral:
                if let difference = Calendar.current.dateComponents([.month], from: reminder.startDate, to: date).month {
                    return difference % 3 == 0
                }
                return false
            case .semestral:
                if let difference = Calendar.current.dateComponents([.month], from: reminder.startDate, to: date).month {
                    return difference % 6 == 0
                }
                return false
            case .annual:
                return isSameDayAndMonth(reminder.startDate, date)
            }
        }
    }
    
//    static func toEnum(repetition: Repetition) -> RepetitionEnum? {
//       
//        for rep in RepetitionEnum.allCases {
//            if rep.frequency == repetition.frequency {
//                return rep
//            }
//        }
//        
//        return nil
//    }
}
