//
//  Send.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 07/11/24.
//

import SwiftUI
import UserNotifications
import SwiftData

func sendNotification(content: UNNotificationContent, notification: NotificationModel, modelContext: ModelContext) {
    
    var formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.timeZone = TimeZone(secondsFromGMT: -3 * 3600)
    let dateString = formatter.string(from: notification.date)
    print("notificação: \(dateString)")
    
    
    var timeInterval = notification.date.timeIntervalSinceNow
    timeInterval += notification.type.timeInterval
    
    if timeInterval < 0 {
        print("tempo inválido: \(timeInterval)")
        return
    }
    
    let notificationCenter = UNUserNotificationCenter.current()
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
    let request = UNNotificationRequest(identifier: notification.modelID, content: content, trigger: trigger)
    
    notificationCenter.add(request) { error in
        if let error = error {
            DispatchQueue.main.async {
                print("Erro ao adicionar notificação: \(error.localizedDescription)")
            }
        } else {
            DispatchQueue.main.async {
                print("Notificação agendada com sucesso!")
                modelContext.insert(notification)
            }
        }
    }
}


