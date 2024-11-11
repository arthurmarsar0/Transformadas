//
//  ReminderComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI
import SwiftData

struct ReminderComponent: View
{
    // MARK: - EXTERNAL
    var reminder: Reminder
    @Binding var selectedDate: Date
    
    // MARK: - DATA
    @Environment(\.modelContext) var modelContext
    @Query var notifications: [NotificationModel]
    
    // MARK: - VIEW DATA
    @State var isChecked: Bool = false
    @State var isShowingReminderSheet = false
    @State var isShowingEditReminderSheet = false
    
    // MARK: - VIEW
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
                            .foregroundStyle(isChecked ? .azul : isFutureDate(selectedDate) ? .cinzaMuitoClaro : .cinzaClaro)
                    }.disabled(isFutureDate(selectedDate))
                    
                    
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
            }.sheet(isPresented: $isShowingReminderSheet, onDismiss: {
                addNavBarBackground()
            }) {
                ReminderSheetView(isShowingReminderSheet: $isShowingReminderSheet, isShowingEditReminderSheet: $isShowingEditReminderSheet, reminder: reminder, isChecked: $isChecked, selectedDate: selectedDate)
                    .presentationDetents([.medium])
                    .interactiveDismissDisabled()
            }.sheet(isPresented: $isShowingEditReminderSheet, onDismiss: {
                addNavBarBackground()
            }) {
                AddReminder(existingReminder: reminder)
                    .interactiveDismissDisabled()
            }
        
        
    }
    
    // MARK: - DATA FUNC
    
    func toggleReminder(isChecked: Bool) {
        var reminderModel = ReminderModel(context: modelContext)
        
        
        if isChecked {
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
            dateComponents.hour = Calendar.current.dateComponents([.hour], from: reminder.time).hour
            dateComponents.minute = Calendar.current.dateComponents([.minute], from: reminder.time).minute
            
            if let targetDate = Calendar.current.date(from: dateComponents) {
                if Date.now < targetDate {
                    deleteReminderNotifications(reminderNotifications: notifications.filter({$0.reminder?.modelID == reminder.modelID}), modelContext: modelContext)
                } else if Date.now < targetDate + TimeInterval(30*60) {
                    deleteReminderNotifications(reminderNotifications: notifications.filter({$0.reminder?.modelID == reminder.modelID && ($0.type == .missingMedicine || $0.type == .afterEvent)}), modelContext: modelContext)
                }
            }
            
            
            
            reminder.daysCompleted.append(selectedDate)
        } else {
            reminder.daysCompleted = reminder.daysCompleted.filter({!isSameDay($0, selectedDate)})
        }
        
        do {
            try reminderModel.editReminder(reminder: reminder)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview() {
    ReminderComponent(reminder: (Reminder(name: "Consulta Endocrinologista", startDate: Date.now, repetition: .never, type: .medicine, time: Date.now, daysCompleted: [], notes: "", dosage: "2mg")), selectedDate: .constant(Date.now))
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
    
}
