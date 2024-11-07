//
//  NotificationsContent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 07/11/24.
//

import SwiftUI
import UserNotifications

func sendMedicineNotification(reminder: Reminder) {
    var content = UNMutableNotificationContent()
    content.title = "\(reminder.name) \(reminder.time)"
    content.body = "Não demore muito!"
    content.sound = UNNotificationSound.default
    
    if let imageAttachment = createAppIconAttachment() {
      content.attachments = [imageAttachment]
    }
    
    sendNotification(content: content, timeInterval: 5)
    
}

func sendMissingMedicineNotification(reminder: Reminder) {
    // 30 minutos depois
    var content = UNMutableNotificationContent()
    content.title = "Você tomou seu medicamento?"
    content.body = "Um lembrete para \(reminder.time) não foi marcado como concluído ainda"
    content.sound = UNNotificationSound.default
    
    if let imageAttachment = createAppIconAttachment() {
      content.attachments = [imageAttachment]
    }
    
    sendNotification(content: content, timeInterval: 5)
    
}

func sendEventNotification(reminder: Reminder) {
    // 10 minutos antes
    var content = UNMutableNotificationContent()
    content.title = "\(reminder.name) \(reminder.time)"
    content.body = "Seu evento começa em 10 minutos"
    content.sound = UNNotificationSound.default
    
    if let imageAttachment = createAppIconAttachment() {
      content.attachments = [imageAttachment]
    }
    
    sendNotification(content: content, timeInterval: 5)
    
}

func sendAfterEventNotification(reminder: Reminder) {
    // 30 minutos depois
    var content = UNMutableNotificationContent()
    content.title = "Como foi o evento \(reminder.name)"
    content.body = "Marque este lembrete como concluído e fale um pouco sobre ele"
    content.sound = UNNotificationSound.default
    
    if let imageAttachment = createAppIconAttachment() {
      content.attachments = [imageAttachment]
    }
    
    sendNotification(content: content, timeInterval: 5)
    
}

func sendAddEntryNotification() {
    // 30 minutos depois
    var content = UNMutableNotificationContent()
    content.title = "Como você está se sentindo?"
    content.body = "Registre mais um dia da sua transição!"
    content.sound = UNNotificationSound.default
    
    if let imageAttachment = createAppIconAttachment() {
      content.attachments = [imageAttachment]
    }
    
    sendNotification(content: content, timeInterval: 5)
    
}

func transversaryNotification(user: User) {
    var content = UNMutableNotificationContent()
    content.title = "Parabéns, \(user.name)"
    content.body = "Hoje é seu Transversário, um dia para festejar você e toda a sua jornada até aqui!"
    content.sound = UNNotificationSound.default
    
    if let imageAttachment = createAppIconAttachment() {
      content.attachments = [imageAttachment]
    }
    
    sendNotification(content: content, timeInterval: 5)
    
}
