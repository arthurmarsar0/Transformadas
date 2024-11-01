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
    @State var selectedDay: Int = Calendar.current.dateComponents([.day, .month], from: Date.now).day ?? 1
    
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
    @State var isShowingEntrySheet: Bool = false
    
    ///VIEW
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bege.ignoresSafeArea()
                
                VStack (spacing: 16){
//                    Image("background")
//                        .offset(y: -195)
//                   
                    
                    dateCarousel()
                    
                    todayReminders()
                    
                    entryArea()
                    
                    if entries.isEmpty {
                        addEntryButton()
                    }
                        
                    
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
        ScrollViewReader { scrollViewProxy in
            VStack(spacing: 8) {
                HStack {
                    Text("\(currentMonthString.prefix(3)) \(currentYear)")
                        .foregroundStyle(.marrom)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedDay = currentDay
                        withAnimation {
                            
                            scrollViewProxy.scrollTo(currentDay, anchor: .center)
                        }
                    }) {
                        Text("Hoje")
                            .foregroundStyle(selectedDay == currentDay ? .cinzaClaro : .vermelho)
                    }
                }
                
                carouselScroll(scrollViewProxy: scrollViewProxy)
            }
        }
    }

    func carouselScroll(scrollViewProxy: ScrollViewProxy) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(monthDates, id: \.self) { date in
                    Button(action: {
                        selectedDay = date.dayNumber
                        withAnimation {
                            scrollViewProxy.scrollTo(date.dayNumber, anchor: .center)
                        }
                    }) {
                        CarouselDayComponent(date: date, state: .noEntry, isSelected: selectedDay == date.dayNumber, todayReminders: [])
                            .padding(.vertical, 4)
                    }
                    .id(date.dayNumber)
                }
            }
        }
        .onAppear {
            scrollViewProxy.scrollTo(selectedDay, anchor: .center)
        }
    }
    
    func entryArea() -> some View {
        VStack (spacing: 8){
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
                    entryPreview(entry: entry)
                }
            }
            
        }
    }
    
    func entryPreview(entry: Entry) -> some View {
        
        VStack (spacing: 16) {
            
            entryButton(entry: entry)
            
            HStack {
                Spacer()
                pullDownButton(entry: entry)
            }
            
        }.padding(12)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
            }
        
        
        
    }
    
    func entryButton(entry: Entry) -> some View {
        Button(action: {
            isShowingEntrySheet = true
        }) {
            if entry.photos.isEmpty {
                entrySemFoto(entry: entry)
            } else if let data = entry.photos.first, let photo = EntryModel.dataToImage(data: data) {
                entryComFoto(entry: entry, photo: photo)
            }
        }.sheet(isPresented: $isShowingEntrySheet) {
            EntryView(entry: entry, isShowingEntrySheet: $isShowingEntrySheet)
        }
    }
    
    func pullDownButton(entry: Entry) -> some View {
        Menu{
            Button ("Apagar", role: .destructive) {
                isShowingDeleteEntry = true
            }
            Button ("Editar") {
                
            }
            
        } label: {
            Image(systemName: "ellipsis")
                .foregroundStyle(.cinzaClaro)
                .font(.system(size: 17))
        }.confirmationDialog("Tem certeza de que deseja apagar este registro?", isPresented: $isShowingDeleteEntry, titleVisibility: .visible) {
            
            Button ("Apagar Registro", role: .destructive) {
                deleteEntry(entry: entry)
            }
            
            Button ("Cancelar", role: .cancel) {
                
            }
        }
    }
    
    func entryComFoto(entry: Entry, photo: Image) -> some View {
        HStack (spacing: 8){
            photo
                .resizable()
                .scaledToFill()
            
            entrySemFoto(entry: entry)
            
        }
    }
    
    func entrySemFoto(entry: Entry) -> some View {
        VStack (spacing: 8){
            if let mood = entry.mood {
                MoodPreviewComponent(mood: mood, entryDate: entry.date, isPreview: true)
            }
            
            if let audio = entry.audio {
                AudioPreviewComponent(audio: audio, isPreview: true)
            }
            if let weight = entry.weight {
                WeightPreviewComponent(weight: weight, isPreview: true)
            }
            if let note = entry.note {
                NotePreviewComponent(note: note, isPreview: true)
            }
            
            if let effects = entry.effects {
                //EffectPreviewComponent(effects: effects, isPreview: true)
            }
            
            if let documents = entry.documents {
                DocumentPreviewComponent(documents: documents, isPreview: true)
            }
        }
    }
    
    func addEntryButton() -> some View {
        Button(action: {
            addEntry()
        }) {
            HStack (spacing: 8){
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 20, weight: .semibold))
                Text("Registrar Dia")
                    .font(.system(size: 17, weight: .semibold))
            }.foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(14)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.rosa)
                }
        }
        
    }
    
    /// DATA  FUNCS
    
    func addEntry() {
        modelContext.insert(Entry(date: Date.now, mood: .bad, note: "Querido diário, hoje eu notei que a minha barba começou a crescer mais nas laterais. O bigode, que já tava maior, agora está engrossando, o que é muito bom", audio: "", photos: [], effects: [Effect(name: "Crescimento das mamas"), Effect(name: "Diminuição de pelos faciais"), Effect(name: "Fadiga"), Effect(name: "Insônia"), Effect(name: "Náusea")], documents: ["arquivo_examesangue_pdf gthyh hyh", "arquivo_examesangue_pdf"], weight: 67.5))
    }
    
    func deleteEntry(entry: Entry) {
        modelContext.delete(entry)
    }
    
}

#Preview {
        Diary()
            .modelContainer(for: [
                Effect.self,
                User.self,
                Entry.self,
                Reminder.self
            ], inMemory: true)
    
    
}
