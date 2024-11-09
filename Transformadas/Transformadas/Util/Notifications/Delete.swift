//
//  Delete.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 08/11/24.
//

import Foundation
import UserNotifications
import SwiftData

func deleteReminderNotifications(reminderNotifications: [NotificationModel], modelContext: ModelContext) {
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.removePendingNotificationRequests(withIdentifiers: reminderNotifications.map({$0.modelID}))
    for notification in reminderNotifications {
        modelContext.delete(notification)
    }
}
