//
//  AppIconAttachment.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 07/11/24.
//

import SwiftUI
import UserNotifications

func createAppIconAttachment() -> UNNotificationAttachment? {
    var systemImage = UIImage(resource: .appIcon)
    let tempDirectory = FileManager.default.temporaryDirectory
    let imageURL = tempDirectory.appendingPathComponent("\(UUID().uuidString).png")
        
    if let pngData = systemImage.pngData() {
      do {
        try pngData.write(to: imageURL)
        let attachment = try UNNotificationAttachment(identifier: UUID().uuidString, url: imageURL, options: nil)
        return attachment
      } catch {
        print("Erro ao criar attachment de imagem: \(error.localizedDescription)")
        return nil
      }
    }
  return nil
}
