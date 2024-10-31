//
//  ReminderComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct ReminderComponent: View
{
    @Environment(\.modelContext) var modelContext
    
    var reminder: Reminder
    
    var body: some View
    {
        VStack (spacing: 4){
            HStack {
                Text(reminder.time.hourFormatted)
                    .foregroundStyle(.cinzaEscuro)
                    .font(.system(size: 15, weight: .regular))
                Spacer()
                Button(action: {
                    toggleReminder()
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.azul)
                }
            }
            Text(reminder.name)
                .font(.system(size: 12, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1...2)
                    .truncationMode(.tail)
                    .lineSpacing(4)
                    .foregroundStyle(reminder.repetition.frequency == 0 ? .azul : .rosa)
                    .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background {
            RoundedRectangle(cornerRadius: 8).fill(.white)
                //.stroke(.gray, lineWidth: 1)
        }
        .frame(width: 189, height: 90)
    }
    
    func toggleReminder() {
        
    }
}

#Preview() {
    ReminderComponent(reminder: Reminder(name: "Consulta Endocrinologista", startDate: Date.now, endDate: Date.distantFuture, repetition: Repetition(frequency: 0), time: Date.now, daysCompleted: []))

}
