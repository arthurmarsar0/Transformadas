//
//  AddReminder.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 04/11/24.
//

import SwiftUI
import SwiftData

struct AddReminder: View {
    // MARK: - EXTERNAL
    //@Binding var isShowingAddReminderSheet: Bool
    var existingReminder: Reminder?
    var selectedDate: Date?
    
    // MARK: - DATA
    @Environment(\.modelContext) var modelContext
    @Query var reminders: [Reminder]
    
    @Environment(\.presentationMode) var presentationMode
    @Query var notifications: [NotificationModel]
    
    // MARK: - VIEW DATA
    @State var reminder = Reminder(name: "", startDate: Date.now, repetition: .never, type: .event, daysOfTheWeek: Array(repeating: false, count: 7), time: Date.now, daysCompleted: [], notes: "", dosage: "")
    
    @State var staticReminder = Reminder(name: "", startDate: Date.now, repetition: .never, type: .event, daysOfTheWeek: Array(repeating: false, count: 7), time: Date.now, daysCompleted: [], notes: "", dosage: "")
    
    @State var isShowingCancelReminder = false
    
    var navTitle: String {
        existingReminder != nil ? "Editar Lembrete" : "Novo Lembrete"
    }
    
    var saveTitle: String {
        existingReminder != nil ? "Salvar" : "Adicionar"
    }
    
    var colors: [Color] {
        if reminder.type == .event {
            return [.verdeClaro, .verdeMedio, .azul, .verde]
        } else {
            return [.rosaClaro, .rosaMedio, .vermelho, .rosa]
        }
    }
    
    var canAddReminder: Bool {
        return reminder.name != "" && (reminder.repetition != .daysOfTheWeek || reminder.daysOfTheWeek.contains(true))
    }
    
    // MARK: - VIEW
    var body: some View {
        NavigationStack {
            ZStack {
                Color.beginho.ignoresSafeArea()
                VStack (spacing: 0){
                    reminderTypePicker()
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    List{
                        Section {
                            TextField(reminder.type == .event ? "Título do Evento" : "Nome do Medicamento", text: $reminder.name)
                                
                            
                            if reminder.type == .event {
                                TextField("Notas", text: $reminder.notes)
                                    //.lineLimit(2...3)
                                   
                            } else {
                                TextField("Dose", text: $reminder.dosage)
                                    
                            }
                        }
                        
                        
                        if reminder.type == .medicine {
                            
                            Section {
                                TextField("Notas", text: $reminder.notes)
                                    //.lineLimit(2...3)
                            }
                        }
                        
                        
                        
                        repetitionPicker()
                        
                        
                        dateAndTimePicker()
                        
                        
                    }
                    
                }
                
            }.navigationTitle(navTitle)
                .navigationBarTitleDisplayMode(.inline)
                .scrollContentBackground(.hidden)
                .background(Color.beginho)
            
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            
                            if (existingReminder != nil && hadChangesOnReminder(oldReminder: existingReminder!, newReminder: reminder)) || (existingReminder == nil && hadChangesOnReminder(oldReminder: staticReminder, newReminder: reminder)) {
                                isShowingCancelReminder = true
                            } else {
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                        }) {
                            Text("Cancelar")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            addReminder()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text(saveTitle)
                                .foregroundStyle(canAddReminder ? colors[3] : colors[0])
                        }.disabled(!canAddReminder)
                    }
                }
                .toolbarBackground(.beginho)
                .toolbarBackgroundVisibility(.visible)
                .modifier(KeyboardDismiss())
        }.onAppear {
            if let selectedDate = selectedDate {
                reminder.startDate = selectedDate
                staticReminder.startDate = selectedDate
            }
            
            removeNavBarBackground()
            if let existingReminder = existingReminder {
                copyReminder(toReminder: reminder, reminder: existingReminder)
            }
            copyReminder(toReminder: staticReminder, reminder: reminder)
        }.confirmationDialog("Tem certeza de que deseja descartar este lembrete?", isPresented: $isShowingCancelReminder, titleVisibility: .visible) {
            
            Button ("Descartar Alterações", role: .destructive) {
                presentationMode.wrappedValue.dismiss()
            }
            
            Button ("Continuar Editando", role: .cancel) {
                
            }
        }
        
    }
    
    // MARK: - VIEW FUNC
    
    func reminderTypePicker() -> some View {
        
        Picker("", selection: $reminder.type) {
            ForEach(ReminderType.allCases, id: \.self) { type in
                Text(type.name)
            }
        }.pickerStyle(.segmented)
        
        
    }
    
    func repetitionPicker() -> some View {
        Section {
            HStack {
                Image(systemName: "repeat")
                    .foregroundStyle(colors[1])
                Text("Repetir")
                    .foregroundStyle(.cinzaEscuro)
                Spacer()
                
                Picker("", selection: $reminder.repetition) {
                    ForEach(Repetition.allCases, id: \.self) { repetition in
                        Text(repetition.name)
                    }
                }
                .foregroundStyle(.cinzaClaro)
                
            }.font(.system(size: 17))
        }
    }
    
    func dateAndTimePicker() -> some View {
        Section (content: {
            if reminder.repetition == .daysOfTheWeek {
                selectWeekDays()
            }
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(colors[1])
                    .bold()
                DatePicker(reminder.repetition == .never ? "Data" : "Data de Início", selection: $reminder.startDate, displayedComponents: [.date])
            }.font(.system(size: 17))
            
            HStack {
                Image(systemName: "clock")
                    .foregroundStyle(colors[1])
                DatePicker("Horário", selection: $reminder.time, displayedComponents: [.hourAndMinute])
            }.font(.system(size: 17))
        }, footer: {
            Text(reminder.repetition.descriptionMessage(startDate: reminder.startDate, selectedWeekDays: reminder.daysOfTheWeek))
                .foregroundStyle(.cinzaEscuro)
                .font(.system(size: 13, weight: .regular))
        })
        
    }
    
    func selectWeekDays() -> some View {
        HStack {
            ForEach(0..<7, id: \.self) { i in
                
                Text(WeekDay.allCases[i].name.prefix(1))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(reminder.daysOfTheWeek[i] ? .white : .marrom)
                    .background {
                        if reminder.daysOfTheWeek[i] {
                            Circle().fill(degradeRosa()).frame(width: 32, height: 32)
                        }
                        
                    }
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        reminder.daysOfTheWeek[i].toggle()
                    }
                
                if i != 6 {
                    Spacer()
                }
                
            }
        }
    }
    
    // MARK: - DATA FUNC
    
    func addReminder() {
        
        if let existingReminder = existingReminder {
            copyReminder(toReminder: existingReminder, reminder: reminder)
            deleteReminderNotifications(reminderNotifications: notifications.filter({$0.reminder?.modelID == reminder.modelID}), modelContext: modelContext)
        } else {
            reminder.startDate = Calendar.current.startOfDay(for: reminder.startDate)
            modelContext.insert(reminder)
        }
    }

}

#Preview {
    AddReminder(existingReminder: nil, selectedDate: Date.now)
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
