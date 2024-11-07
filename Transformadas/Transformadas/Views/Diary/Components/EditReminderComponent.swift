//
//  Untitled.swift
//  Transformadas
//
//  Created by Alice Barbosa on 06/11/24.
//

import SwiftUI

struct EditReminderComponent: View {
    var reminder: Reminder
    var body: some View {
            VStack(alignment: .leading, spacing: 4){
                Text(reminder.time.hourFormatted)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.cinzaClaro)
                Text(reminder.name)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(reminder.type.name == "Evento" ? .verde : .vermelho)
                Text(reminder.notes)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.cinzaEscuro)
                HStack{
                    Image(systemName: "calendar")
                    
                    Text(reminder.repetition.name)
                }
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(reminder.type.name == "Evento" ? .verdeMedio : .rosaMedio)
                if(reminder.type.name == "Medicamento"){
                    HStack{
                        Image(systemName: "pill")
                        Text(reminder.dosage)
                    }
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.rosaMedio)
                }
            }.padding(12)
            .background{
                RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.white)
            }
               
        
    }
}

