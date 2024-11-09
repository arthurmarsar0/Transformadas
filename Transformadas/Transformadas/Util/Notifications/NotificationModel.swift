//
//  NotificationModel.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 07/11/24.
//

import Foundation
import SwiftData
import UserNotifications

@Model
class NotificationModel {
    var modelID: String = UUID().uuidString
    var state: NotificationState = NotificationState.send
    @Relationship(deleteRule: .nullify, inverse: \Reminder.notifications) var reminder: Reminder?
    var type: NotificationType = NotificationType.takeMedicine
    var date: Date = Date.now
    
    init(reminder: Reminder? = nil, type: NotificationType, date: Date) {
        self.reminder = reminder
        self.type = type
        self.date = date
    }
}

enum NotificationState: Codable {
    case send
    case delivered
}

enum NotificationType: Codable {
    case takeMedicine
    case missingMedicine
    case rememberEvent
    case afterEvent
    case makeEntry
    case transversary
    
    func title(reminder: Reminder? = nil, user: User? = nil) -> String {
        switch self {
        case .takeMedicine:
            return "\(reminder!.name) \(reminder!.time.hourFormatted)"
        case .missingMedicine:
            return "Você tomou seu medicamento?"
        case .rememberEvent:
            return "\(reminder!.name) \(reminder!.time.hourFormatted)"
        case .afterEvent:
            return "Como foi o evento \(reminder!.name)"
        case .makeEntry:
            return "Como você está se sentindo?"
        case .transversary:
            return "Parabéns, \(user!.name)"
        }
    }
    
//    func subtitle(reminder: Reminder) -> String {
//        
//    }
    
    func body(reminder: Reminder? = nil) -> String {
        switch self {
        case .takeMedicine:
            return "Não demore muito!"
        case .missingMedicine:
            return "Um lembrete para \(reminder!.time.hourFormatted) não foi marcado como concluído ainda"
        case .rememberEvent:
            return "Seu evento começa em 10 minutos"
        case .afterEvent:
            return "Marque este lembrete como concluído e fale um pouco sobre ele"
        case .makeEntry:
            return "Registre mais um dia da sua transição!"
        case .transversary:
            return "Hoje é seu Transversário, um dia para festejar você e toda a sua jornada até aqui!"
        }
    }
    
    var sound: UNNotificationSound {
        return UNNotificationSound.default
    }
    
    var attachment: UNNotificationAttachment? {
        return createAppIconAttachment()
    }
    
    var timeInterval: TimeInterval {
        switch self {
        case .takeMedicine:
            return 0
        case .missingMedicine:
            return 30*60
        case .rememberEvent:
            return -10*60
        case .afterEvent:
            return 30*60
        case .makeEntry:
            return 0
        case .transversary:
            return 0
        }
    }
}
