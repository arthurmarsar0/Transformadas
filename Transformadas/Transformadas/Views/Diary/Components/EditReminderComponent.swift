//
//  Untitled.swift
//  Transformadas
//
//  Created by Alice Barbosa on 06/11/24.
//

import SwiftUI

struct EditReminderComponent: View {
    var reminder: Reminder
    
    var colors: [Color] {
        if reminder.type == .event {
            return [.azul, .verdeMedio]
        } else {
            return [.vermelho, .rosaMedio]
        }
    }
    var body: some View {
            VStack(alignment: .leading, spacing: 4){
                Text(reminder.time.hourFormatted)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.cinzaClaro)
                Text(reminder.name)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(colors[0])
                Text(reminder.notes)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.cinzaEscuro)
                
                HStack (spacing: 4){
                    Image(systemName: "calendar")
                    
                    Text(reminder.repetition.name)
                }
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(colors[1])
                
                if(reminder.type == .medicine){
                    HStack (spacing: 4) {
                        Image(systemName: "pill")
                        Text(reminder.dosage)
                    }
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.rosaMedio)
                }
            }
            .padding(.vertical, 12)
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
            }
               
        
    }
}

