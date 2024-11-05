//
//  ReminderSheetView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 02/11/24.
//

import SwiftUI

struct ReminderSheetView: View {
    ///EXTERNAL
    @Binding var isShowingReminderSheet: Bool
    @Binding var isShowingEditReminderSheet: Bool
    
    ///VIEW DATA
    var reminder: Reminder
    @Binding var isChecked: Bool
    
    var colors: [Color] {
        if reminder.type == .event {
            return [.azul, .verde]
        } else {
            return [.vermelho, .rosa]
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 16) {
                Text(reminder.time.hourFormatted)
                    .font(.system(size: 28, weight: .regular))
                    .foregroundStyle(.cinzaEscuro)
                
                VStack (alignment: .leading, spacing: 8){
                    Text(reminder.name)
                        .font(.system(size: 22, weight: .regular))
                        .foregroundStyle(colors[0])
                    
                    Text(reminder.notes)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                }
                
                VStack (alignment: .leading, spacing: 8){
                    HStack (spacing: 4){
                        Image(systemName: "calendar")
                    
                            Text(reminder.repetition.name)
                        
                        
                    }
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.cinzaClaro)
                    
                    if reminder.type == .medicine {
                        HStack (spacing: 4){
                            Image(systemName: "pill")
                            Text(reminder.dosage)
                            
                        }
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.cinzaClaro)
                    }
                }
                
                
                if isChecked {
                    checked()
                } else {
                    checkButton()
                        .padding(.top, 24)
                }
                
                
                //Spacer()
                
            }
            .padding(16)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Editar") {
                        isShowingReminderSheet = false
                        isShowingEditReminderSheet = true
                    }
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.cinzaEscuro)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("OK") {
                        isShowingReminderSheet = false
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(colors[1])
                }
            }
            //.navigationBarWithImageBackground(createColorImage(size: CGSizeMake(100, 100), color: .white))
            //.modifier(NavigationBarModifier(backgroundImage: createColorImage(size: CGSizeMake(100, 100), color: .white)))
        }.onAppear {
            removeNavBarBackground()
        }
    }
    
    func checkButton() -> some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack (spacing: 8){
                Text("Marcar Lembrete como Concluído")
                    .font(.system(size: 17, weight: .semibold))
            }.foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(14)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colors[1])
                }
        }
        
    }
    
    func checked() -> some View {
        
        HStack (spacing: 8){
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 20, weight: .semibold))
            Text("Lembrete Marcado como Concluído")
                .font(.system(size: 17, weight: .semibold))
        }.foregroundStyle(colors[1])
            .frame(maxWidth: .infinity)
            .padding(14)
    }
}

//#Preview {
//    let preview = Preview()
//    preview.addEntriesExamples(EntryModel.samples)
//    preview.addEffectsExamples(EffectModel.samples)
//    preview.addRemindersExamples(ReminderModel.samples)
//    
//    NavigationStack {
//        ReminderSheetView(isShowingReminderSheet: .constant(true), reminder: Reminder(name: "Consulta Endocrinologista", startDate: Date.now, repetition: Repetition.never, type: .medicine, time: Date.now, daysCompleted: [], notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in ornare tellus. ", dosage: "2mg"), isChecked: .constant(true))
//    }
//    .modelContainer(preview.modelContainer)
//    
//}
