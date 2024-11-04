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
    @Binding var selectedDate: Date
    
    @State var isChecked: Bool = false
    @State var isShowingReminderSheet = false
    
    var body: some View
    {
            VStack {
                HStack (alignment: .top, spacing: 4) {
                    VStack (alignment: .leading, spacing: 4) {
                        //Spacer()
                        
                        Text(reminder.time.hourFormatted)
                            .foregroundStyle(.cinzaEscuro)
                            .font(.system(size: 15, weight: .regular))
                        
                        Text(reminder.name)
                            .font(.system(size: 12, weight: .medium))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1...2)
                        //.truncationMode(.tail)
                            .lineSpacing(4)
                            .foregroundStyle(reminder.type == .event ? .azul : .rosa)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.frame(maxHeight: .infinity, alignment: .bottom)
                    
                    Button(action: {
                        isChecked.toggle()
                    }) {
                        Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(isChecked ? .azul : .cinzaClaro)
                    }
                    
                    
                }
            }
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: 8).fill(.white)
                //.stroke(.gray, lineWidth: 1)
            }
            .frame(width: 189, height: 80)
            .onAppear {
                self.isChecked = reminder.daysCompleted.contains(where: {isSameDay($0, selectedDate)})
            }
            .onChange(of: isChecked) {
                toggleReminder(isChecked: isChecked)
            }.onTapGesture {
                isShowingReminderSheet = true
            }.sheet(isPresented: $isShowingReminderSheet) {
                ReminderSheetView(isShowingReminderSheet: $isShowingReminderSheet, reminder: reminder, isChecked: $isChecked)
                    .presentationDetents([.medium])
            }
        
        
    }
    
    func toggleReminder(isChecked: Bool) {
        var reminderModel = ReminderModel(context: modelContext)
        
        
        if isChecked {
            reminder.daysCompleted.append(selectedDate)
        } else {
            reminder.daysCompleted = reminder.daysCompleted.filter({isSameDay($0, selectedDate)})
        }
        
        do {
            try reminderModel.editReminder(reminder: reminder)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview() {
    ReminderComponent(reminder: (Reminder(name: "Consulta Endocrinologista", startDate: Date.now, endDate: Date.distantFuture, repetition: Repetition(frequency: 0), type: .medicine, time: Date.now, daysCompleted: [], notes: "", dosage: "2mg")), selectedDate: .constant(Date.now))
    
}
