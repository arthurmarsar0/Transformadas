//
//  NotificationsContent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 07/11/24.
//

import SwiftUI
import UserNotifications
import SwiftData

func sendReminderNotification(reminder: Reminder, type: NotificationType, targetDate: Date, modelContext: ModelContext) {
    
    var content = UNMutableNotificationContent()
    content.title = type.title(reminder: reminder, user: nil)
    content.body = type.body(reminder: reminder)
    content.sound = type.sound
    
    if let imageAttachment = type.attachment {
      content.attachments = [imageAttachment]
    }
    
    var notificationComponents = Calendar.current.dateComponents([.year, .month, .day], from: targetDate)
    notificationComponents.hour = Calendar.current.component(.hour, from: reminder.time)
    notificationComponents.minute = Calendar.current.component(.minute, from: reminder.time)
    
    
    if let targetDate = Calendar.current.date(from: notificationComponents) {
        var notification = NotificationModel(reminder: reminder, type: type, date: targetDate)
        print("chamada 2")
        sendNotification(content: content, notification: notification, modelContext: modelContext)
        
    }
}

func sendEntryNotification(targetDate: Date, modelContext: ModelContext) {
    
    var content = UNMutableNotificationContent()
    content.title = NotificationType.makeEntry.title()
    content.body = NotificationType.makeEntry.body()
    content.sound = NotificationType.makeEntry.sound
    
    if let imageAttachment = NotificationType.makeEntry.attachment {
      content.attachments = [imageAttachment]
    }
    
    var notificationComponents = Calendar.current.dateComponents([.year, .month, .day], from: targetDate)
    notificationComponents.hour = 12
    notificationComponents.minute = 0
    
    
    if let targetDate = Calendar.current.date(from: notificationComponents) {
        var notification = NotificationModel(type: .makeEntry, date: targetDate)
        
        sendNotification(content: content, notification: notification, modelContext: modelContext)
    }
    
}

func sendTransversaryNotification(user: User, targetDate: Date, modelContext: ModelContext) {
    
    var content = UNMutableNotificationContent()
    content.title = NotificationType.transversary.title(user: user)
    content.body = NotificationType.transversary.body()
    content.sound = NotificationType.transversary.sound
    
    if let imageAttachment = NotificationType.transversary.attachment {
      content.attachments = [imageAttachment]
    }
    
    var notificationComponents = Calendar.current.dateComponents([.year, .month, .day], from: targetDate)
    notificationComponents.hour = 12
    notificationComponents.minute = 0
    
    
    if let targetDate = Calendar.current.date(from: notificationComponents) {
        var notification = NotificationModel(type: .transversary, date: targetDate)
        
        sendNotification(content: content, notification: notification, modelContext: modelContext)
    }
    
}
