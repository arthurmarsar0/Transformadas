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
    @State var selectedDate: Date = Date.now
    
    var monthDates: [Date] {
        return datesInCurrentMonth()
    }
    
    @State var isShowingDeleteEntry: Bool = false
    @State var isShowingEntrySheet: Bool = false
    
    var selectedDayReminders: [Reminder] {
        return reminders.filter({isSameDay($0.startDate, selectedDate)})
    }
    
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
                    
                    if !entries.contains(where: { isSameDay($0.date, selectedDate) }) {
                        addEntryButton(selectedDate: selectedDate)
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
            if !reminders.contains(where: { isSameDay($0.startDate, selectedDate) }) {
                VStack {
                    Spacer()
                    Text("Sem lembretes")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    Spacer()
                }
            } else {
                ScrollView(.horizontal) {
                    HStack (spacing: 16) {
                        ForEach(selectedDayReminders) { reminder in
                            ReminderComponent(reminder: reminder, selectedDate: $selectedDate)
                        }
                    }
                }
            }
        }
    }
    
    func dateCarousel() -> some View {
        ScrollViewReader { scrollViewProxy in
            VStack(spacing: 8) {
                HStack {
                    Text("\(Date.now.monthString.prefix(3)) \(Date.now.yearNumber)")
                        .foregroundStyle(.marrom)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedDate = Date.now
                        withAnimation {
                            
                            scrollViewProxy.scrollTo(Date.now.dayNumber, anchor: .center)
                        }
                    }) {
                        Text("Hoje")
                            .foregroundStyle(isSameDay(selectedDate, Date.now) ? .cinzaClaro : .vermelho)
                    }.disabled(isSameDay(selectedDate, Date.now))
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
                        selectedDate = date
                        withAnimation {
                            scrollViewProxy.scrollTo(date.dayNumber, anchor: .center)
                        }
                    }) {
                        CarouselDayComponent(date: date, state: getDateState(date: date), isSelected: isSameDay(selectedDate, date), todayReminders: [])
                            .padding(.vertical, 4)
                    }
                    .id(date.dayNumber)
                }
            }
        }
        .onAppear {
            scrollViewProxy.scrollTo(selectedDate.dayNumber, anchor: .center)
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
            
            if !entries.contains(where: { isSameDay($0.date, selectedDate) }) {
                VStack {
                    Spacer()
                    Text("Sem registros")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    Spacer()
                }
            } else {
                if let entry = entries.filter({ isSameDay($0.date, selectedDate)}).first {
                    entryPreview(entry: entry)
                }
            }
            
        }
    }
    
    func entryPreview(entry: Entry) -> some View {
        
        VStack (spacing: 16) {
            
            entryButton(entry: entry)
                .frame(maxHeight: 260)
                .clipped()
            
            HStack {
                Spacer()
                pullDownButton(entry: entry)
            }
            
        }
        .padding(12)
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
                .font(.system(size: 24, weight: .regular))
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
                .scaledToFit()
            
            entrySemFoto(entry: entry)
            
        }
    }
    
    func entrySemFoto(entry: Entry) -> some View {
        VStack (spacing: 8){
            Spacer()
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
    
    func addEntryButton(selectedDate: Date) -> some View {
        Button(action: {
            addEntry(selectedDate: selectedDate)
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
                        .fill(isFutureDate(selectedDate) ?  .cinzaMuitoClaro : .rosa)
                }
        }.disabled(isFutureDate(selectedDate))
        
    }
    
    /// DATA  FUNCS
    
    func addEntry(selectedDate: Date) {
        modelContext.insert(Entry(date: Date.now, mood: .bad, note: "Querido diário, hoje eu notei que a minha barba começou a crescer mais nas laterais. O bigode, que já tava maior, agora está engrossando, o que é muito bom", audio: "", photos: [EntryModel.imageToData(image: UIImage(systemName: "calendar")!)!, EntryModel.imageToData(image: UIImage(systemName: "calendar")!)!, EntryModel.imageToData(image: UIImage(systemName: "calendar")!)!], effects: [Effect(name: "Crescimento das mamas"), Effect(name: "Diminuição de pelos faciais"), Effect(name: "Fadiga"), Effect(name: "Insônia"), Effect(name: "Náusea")], documents: ["arquivo_examesangue_pdf gthyh hyh", "arquivo_examesangue_pdf"], weight: 67.5))
        modelContext.insert(Reminder(name: "Consulta Endocrinologista", startDate: Date.now, endDate: Date.distantFuture, repetition: Repetition(frequency: 0), time: Date.now, daysCompleted: []))
    }
    
    func deleteEntry(entry: Entry) {
        modelContext.delete(entry)
    }
    
    func getDateState(date: Date) -> DayComponentState {
        var hasEntries = false
        var isToday = false
        
        if isFutureDate(date) {
            return .future
        }
        
        if entries.contains(where: { isSameDay($0.date, date) }) {
            hasEntries = true
        }
        
        if isSameDay(date, Date.now) {
            isToday = true
        }
        
        if !hasEntries && !isToday {
            return .noEntry
        }
        if hasEntries && !isToday {
            return .withEntry
        }
        if !hasEntries && isToday {
            return .todayNoEntry
        }
        if hasEntries && isToday {
            return .todayWithEntry
        }
        
        return .noEntry
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
