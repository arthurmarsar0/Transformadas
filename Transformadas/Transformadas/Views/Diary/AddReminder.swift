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
    @Binding var isShowingAddReminderSheet: Bool
    var existingReminder: Reminder?
    
    // MARK: - DATA
    @Environment(\.modelContext) var modelContext
    @Query var reminders: [Reminder]
    
    // MARK: - VIEW DATA
    @State var reminder = Reminder(name: "", startDate: Date.now, repetition: .never, type: .event, time: Date.now, daysCompleted: [], notes: "", dosage: "")
    
    @State var staticReminder = Reminder(name: "", startDate: Date.now, repetition: .never, type: .event, time: Date.now, daysCompleted: [], notes: "", dosage: "")
    
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
        return reminder.name != "" && (reminder.repetition != .daysOfTheWeek || selectedWeekDays.contains(true))
    }
    
    @State var selectedWeekDays: [Bool] = Array(repeating: false, count: WeekDay.allCases.count)
    
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
                                .modifier(KeyboardDismiss())
                            
                            if reminder.type == .event {
                                TextField("Notas", text: $reminder.notes)
                                    .modifier(KeyboardDismiss())
                            } else {
                                TextField("Dose", text: $reminder.dosage)
                                    .modifier(KeyboardDismiss())
                            }
                        }
                        
                        
                        if reminder.type == .medicine {
                            
                            Section {
                                TextField("Notas", text: $reminder.notes)
                                    .modifier(KeyboardDismiss())
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
                                isShowingAddReminderSheet = false
                            }
                            
                        }) {
                            Text("Cancelar")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            addReminder()
                            isShowingAddReminderSheet = false
                        }) {
                            Text(saveTitle)
                                .foregroundStyle(canAddReminder ? colors[3] : colors[0])
                        }.disabled(!canAddReminder)
                    }
                }
                .toolbarBackground(.beginho)
                .toolbarBackgroundVisibility(.visible)
        }.onAppear {
            removeNavBarBackground()
            if let existingReminder = existingReminder {
                copyReminder(toReminder: reminder, reminder: existingReminder)
            }
            copyReminder(toReminder: staticReminder, reminder: reminder)
        }.confirmationDialog("Tem certeza de que deseja descartar este lembrete?", isPresented: $isShowingCancelReminder, titleVisibility: .visible) {
            
            Button ("Descartar Alterações", role: .destructive) {
                isShowingAddReminderSheet = false
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
                DatePicker("Horário", selection: $reminder.startDate, displayedComponents: [.hourAndMinute])
            }.font(.system(size: 17))
        }, footer: {
            Text(reminder.repetition.descriptionMessage(startDate: reminder.startDate, selectedWeekDays: selectedWeekDays))
                .foregroundStyle(.cinzaEscuro)
                .font(.system(size: 13, weight: .regular))
        })
        
    }
    
    func selectWeekDays() -> some View {
        HStack {
            ForEach(0..<7, id: \.self) { i in
                
                Text(WeekDay.allCases[i].name.prefix(1))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(selectedWeekDays[i] ? .white : .marrom)
                    .background {
                        if selectedWeekDays[i] {
                            Circle().fill(degradeRosa()).frame(width: 32, height: 32)
                        }
                        
                    }
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        selectedWeekDays[i].toggle()
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
        } else {
            modelContext.insert(reminder)
        }
    }

}

#Preview {
    AddReminder(isShowingAddReminderSheet: .constant(true), existingReminder: nil)
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
