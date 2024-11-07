//
//  Send.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 07/11/24.
//

import SwiftUI
import UserNotifications

func sendNotification(content: UNNotificationContent, timeInterval: TimeInterval) {
    let notificationCenter = UNUserNotificationCenter.current()
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    notificationCenter.add(request) { error in
        if let error = error {
            DispatchQueue.main.async {
                print("Erro ao adicionar notificação: \(error.localizedDescription)")
            }
        } else {
            DispatchQueue.main.async {
                print("Notificação agendada com sucesso!")
            }
        }
    }
}

