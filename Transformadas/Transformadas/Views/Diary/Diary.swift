//
//  Diary.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 29/10/24.
//

import SwiftUI
import SwiftData

struct Diary: View {
    static var now: Date { Date.now }
    
    ///DATA
    @Environment(\.modelContext) var modelContext
    @Query var entries: [Entry]
    @Query var reminders: [Reminder]
    
    @Query(filter: #Predicate<Entry> { entry in
        entry.date.monthNumber == now.monthNumber && entry.date.yearNumber == now.yearNumber
    }) var monthEntries: [Entry]
    
    ///VIEW DATA
    @State var selectedDay  = Calendar.current.dateComponents([.day, .month], from: Date.now).day
    
    var currentMonthString: String {
        return Date.now.monthString
    }
    var currentDay: Int {
        return Date.now.dayNumber
    }
    var currentMonth: Int {
        return Date.now.monthNumber
    }
    var currentYear: Int {
        return Date.now.yearNumber
    }
    
    var monthDates: [Date] {
        return datesInCurrentMonth()
    }
    
    @State var isShowingDeleteEntry: Bool = false
    
    ///VIEW
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bege.ignoresSafeArea()
                
                VStack (spacing: 16){
                    //                    Image("background")
                    //                        .offset(y: -195)
                    //                    Spacer()
                    
                    dateCarousel()
                    
                    todayReminders()
                    
                    entryButton()
                    
                    Spacer()
                }.padding(16)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("Diário")
                                .font(.largeTitle)
                                .fontWeight(.medium)
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "plus")
                                
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "calendar")
                                
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "ellipsis.circle")
                                
                            }
                        }
                        
                    }.foregroundStyle(.black)
                
            }
            
        }
        
    }
    
    ///VIEW FUNCS
    
    func todayReminders() -> some View {
        VStack (spacing: 8){
            HStack {
                Text("Para este dia:")
                    .foregroundStyle(.marrom)
                    .font(.system(size: 17, weight: .regular))
                Spacer()
            }
            
            ///TO-DO
            if reminders.isEmpty {
                VStack {
                    Spacer()
                    Text("Sem lembretes")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    Spacer()
                }
            } else {
                ScrollView(.horizontal) {
                    ForEach(reminders) { reminder in
                        ReminderComponent(reminder: reminder)
                    }
                }
            }
        }
    }
    
    func dateCarousel() -> some View {
        VStack (spacing: 8){
            HStack {
                Text("\(currentMonthString.prefix(3)) \(currentYear)").foregroundStyle(.marrom)
                
                Spacer()
                
                Button(action: {
                    selectedDay = currentDay
                }) {
                    Text("Hoje")
                        .foregroundStyle(selectedDay == currentDay ? .cinzaClaro : .vermelho)
                }
                
            }
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(monthDates, id: \.self) { date in
                            Button(action: {
                                selectedDay = date.dayNumber
                                withAnimation {
                                    scrollViewProxy.scrollTo(date.dayNumber, anchor: .center) // Rola até o dia selecionado
                                }
                            }) {
                                CarouselDayComponent(date: date, state: .noEntry, isSelected: selectedDay == date.dayNumber, todayReminders: [])
                                    .padding(.vertical, 4)
                            }
                            .id(date.dayNumber) // Define o ID do botão para rolagem
                        }
                    }
                }
                .onAppear {
                    if let selectedDay = selectedDay {
                        // Centraliza no selectedDay quando a view aparece
                        scrollViewProxy.scrollTo(selectedDay, anchor: .center)
                    }
                }
            }
            
            
        }
    }
    
    func entryButton() -> some View {
        VStack {
            HStack {
                Text("Como está se sentindo?")
                    .foregroundStyle(.marrom)
                    .font(.system(size: 17, weight: .regular))
                Spacer()
            }
            
            if entries.isEmpty {
                VStack {
                    Spacer()
                    Text("Sem registros")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    Spacer()
                }
            } else {
                if let entry = entries.first {
                    VStack (spacing: 12){
                        
                        if entry.photos.isEmpty {
                            entrySemFoto(entry: entry, isReduced: false)
                        } else if let data = entry.photos.first, let photo = EntryModel.dataToImage(data: data) {
                            entryComFoto(entry: entry, photo: photo)
                        }
                        
                        Menu{
                            Button ("Editar") {
                                
                            }
                            Button ("Apagar", role: .destructive) {
                                
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.cinzaClaro)
                        }
                    }.padding(12)
                        .background(.white)
                        .confirmationDialog("Tem certeza de que deseja apagar este registro?", isPresented: $isShowingDeleteEntry) {
                            
                            Button ("Apagar", role: .destructive) {
                                
                            }
                            
                            Button ("Cancelar", role: .cancel) {
                                
                            }
                        }
                    
                }
            }
            
        }
    }
    
    func entryComFoto(entry: Entry, photo: Image) -> some View {
        HStack (spacing: 8){
            photo
                .resizable()
                .scaledToFill()
                .frame(width: 164.5, height: 260)
            VStack {
                entrySemFoto(entry: entry, isReduced: true)
            }
        }
    }
    
    func entrySemFoto(entry: Entry, isReduced: Bool) -> some View {
        VStack (spacing: 8){
            if let mood = entry.mood {
                MoodPreviewComponent(mood: mood, entryDate: entry.date, isReduced: isReduced)
            }
            
            if let audio = entry.audio {
                AudioPreviewComponent(audio: audio, isReduced: isReduced)
            }
            if let weight = entry.weight {
                WeightPreviewComponent(weight: weight, isReduced: isReduced)
            }
            if let note = entry.note {
                NotePreviewComponent(note: note, isReduced: isReduced)
            }
            
            if let effects = entry.effects {
                EffectPreviewComponent(effects: effects, isReduced: isReduced)
            }
            
            if let documents = entry.documents {
                DocumentPreviewComponent(documents: documents, isReduced: isReduced)
            }
        }
    }
    
    /// DATA  FUNCS
    
}

#Preview {
    Diary()
}
