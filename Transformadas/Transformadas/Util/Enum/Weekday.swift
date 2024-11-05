//
//  Weekday.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 04/11/24.
//

import Foundation

enum WeekDay: Int, CaseIterable {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    var name: String {
        switch self {
            case .sunday: return "Domingo"
            case .monday: return "Segunda-feira"
            case .tuesday: return "Terça-feira"
            case .wednesday: return "Quarta-feira"
            case .thursday: return "Quinta-feira"
            case .friday: return "Sexta-feira"
            case .saturday: return "Sábado"
        }
    }
}
