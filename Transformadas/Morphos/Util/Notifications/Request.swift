//
//  Request.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 07/11/24.
//

import SwiftUI
import UserNotifications

func requestNotificationAccess(completion: @escaping (Bool) -> Void) {
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.getNotificationSettings { settings in
        if settings.authorizationStatus == .authorized {
            DispatchQueue.main.async {
                completion(true)
            }
        } else {
            notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Erro ao solicitar permissão: \(error.localizedDescription)")
                        completion(false)
                    } else {
                        completion(granted)
                    }
                }
            }
        }
    }
}
