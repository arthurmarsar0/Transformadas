//
//  ManageRemindersView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 06/11/24.
//


import SwiftUI
import SwiftData


struct ManageRemindersView: View {
    @State var reminderType: ReminderType = .event
    @Environment(\.presentationMode) var presentationMode
    @State var isSheetPresented: Bool = false
    @Query var reminders: [Reminder]
    @Environment(\.modelContext) var modelContext
    
    @Query var notifications: [NotificationModel]
    
    @State var selectedReminder: Reminder?
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.bege.ignoresSafeArea()
                VStack(alignment: .leading){
                    HStack{
                        Text("Meus lembretes")
                            .font(.system(size: 28, weight: .regular))
                        Spacer()
                    }
                    reminderTypePicker()
                    List{
                        ForEach(reminders.filter({$0.type == reminderType}).sorted(by: {$0.time < $1.time})) { reminder in
                            EditReminderComponent(reminder: reminder)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                    Button(role: .destructive) {
                                        print("deletando...")
                                        modelContext.delete(reminder)
                                        deleteReminderNotifications(reminderNotifications: notifications.filter({$0.reminder?.modelID == reminder.modelID}), modelContext: modelContext)
                                    } label: {
                                        Label("Deletar", systemImage: "trash.fill")
                                    }
                                    
                                    Button {
                                        selectedReminder = reminder
                                        //isSheetPresented = true
                                    } label: {
                                        Label("Editar", systemImage: "pencil")
                                    }
                                    .tint(.gray)
                                    
                                    
                                    
                                }
                        }
                    }.scrollContentBackground(.hidden)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.left")
                            Text("Voltar")
                        }
                        .foregroundStyle(.black)
                        
                        .font(.system(size: 17, weight: .semibold))
                    }

                   }
            }.sheet(item: $selectedReminder, onDismiss: {
                addNavBarBackground()
            }) { reminder in
                    AddReminder(existingReminder: reminder)
                    .interactiveDismissDisabled()
                }

        }
        
    }
    func reminderTypePicker() -> some View {
        
        Picker("", selection: $reminderType) {
            ForEach(ReminderType.allCases, id: \.self) { type in
                Text(type.name)
            }
        }.pickerStyle(.segmented)
        
        
    }
}
