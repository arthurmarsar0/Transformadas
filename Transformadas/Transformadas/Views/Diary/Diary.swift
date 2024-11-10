//
//  Diary.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 29/10/24.
//

import SwiftUI
import SwiftData
import ShimmeringUiView

struct Diary: View {
    
    // MARK: - DATA
    @Environment(\.modelContext) var modelContext
    @Query var entries: [Entry]
    @Query var reminders: [Reminder]
    
    @Query(filter: #Predicate<Entry> { entry in
        entry.date.monthNumber == now.monthNumber && entry.date.yearNumber == now.yearNumber
    }) var monthEntries: [Entry]
    
    @Query var notifications: [NotificationModel]
    
    // MARK: - VIEW DATA
    
    /// DATES
    @State var selectedDate: Date = Date.now
    static var now: Date { Date.now }
    
    var monthDates: [Date] {
        return datesInCurrentMonth()
    }
    
    /// REMINDER
    @State var selectedDayReminders: [Reminder] = []
    @State var monthReminders: [Date:[Reminder]] = [:]
    @State var isLoadingReminders: Bool = false
    @State var isLoadingReminder: Bool = false
    
    /// SHEETS
    @State var isShowingDeleteEntry: Bool = false
    @State var isShowingEntrySheet: Bool = false
    @State var isShowingReminderSheet: Bool = false
    @State var isShowingAddReminderSheet: Bool = false
    @State var isShowingAddEntrySheet: Bool = false
    @State var isShowingEditEntrySheet = false
    
    @State var isCalendarView: Bool = false
    
    
    
    // MARK: - VIEW
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bege.ignoresSafeArea()
                
                ScrollView {
                    VStack (spacing: 16){
                        
                        if !isCalendarView {
                            dateCarousel()
                        } else {
                            calendar()
                        }
                        
                        todayReminders()
                        
                        entryArea()
                        
                        
                        if !entries.contains(where: { isSameDay($0.date, selectedDate) }) {
                            addEntryButton(selectedDate: selectedDate)
                        }
                        
                    }.padding(16)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Text("Diário")
                                    .font(.largeTitle)
                                    .fontWeight(.medium)
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: {
                                    isShowingAddReminderSheet = true
                                }) {
                                    Image(systemName: "plus")
                                    
                                }.sheet(isPresented: $isShowingAddReminderSheet, onDismiss: {
                                    addNavBarBackground()
                                }) {
                                    AddReminder(selectedDate: selectedDate)
                                        .interactiveDismissDisabled()
                                }
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: {
                                    isCalendarView.toggle()
                                }) {
                                    Image(systemName: isCalendarView ? "10.circle" : "calendar")
                                    
                                }
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                Menu{
                                    NavigationLink(destination: ManageRemindersView().navigationBarBackButtonHidden()) {
                                        HStack {
                                            Text("Gerenciar Lembretes")
                                                .font(.headline)
                                            Image(systemName: "gear")
                                        }
                                        .foregroundStyle(.cinzaEscuro)
                                    }
                                }label: {
                                    Image(systemName: "ellipsis.circle")
                                }
                                
                                
                            }
                            
                        }.foregroundStyle(.black)
                }
                    
                
            }.onAppear {
                addNavBarBackground()
            }.task {
                await loadTodayReminders()
                await loadAllReminders()
                loadNotifications()
            }
            .onChange(of: selectedDate) {
                Task {
                    await loadTodayReminders()
                }
                
            }.onChange(of: reminders) {
                Task {
                    await loadTodayReminders()
                    await loadAllReminders()
                    loadNotifications()
                }
            }
        }
        
    }
    
    // MARK: - VIEW FUNCS
    
    func todayReminders() -> some View {
        VStack (spacing: 8){
            HStack {
                Text("Para este dia:")
                    .foregroundStyle(.marrom)
                    .font(.system(size: 17, weight: .regular))
                Spacer()
                if isCalendarView {
                    Button(action: {
                        selectedDate = Date.now
                    }) {
                        Text("Hoje")
                            .foregroundStyle(isSameDay(selectedDate, Date.now) ? .cinzaClaro : .vermelho)
                    }.disabled(isSameDay(selectedDate, Date.now))
                }
            }
            
            if isLoadingReminder {
                ScrollView(.horizontal) {
                    HStack (spacing: 16) {
                        RoundedRectangle(cornerRadius: 8)
                           .frame(width: 189, height: 80)
                           .shimmering()
                        RoundedRectangle(cornerRadius: 8)
                           .frame(width: 189, height: 80)
                           .shimmering()
                    }
                }
            } else if selectedDayReminders.isEmpty {
                VStack {
                    Spacer()
                    Text("Sem lembretes")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    Spacer()
                }
                .frame(height: 80)
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
                        CarouselDayComponent(date: date, state: getDateState(date: date), isSelected: isSameDay(selectedDate, date), todayReminders: monthReminders[date] ?? [])
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
    
    func calendar() -> some View {
        DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
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
        
        VStack (spacing: 32) {
            
            entryButton(entry: entry)
                .frame(maxHeight: 260)
                .clipped()
            
            HStack {
                Spacer()
                pullDownButton(entry: entry)
            }
            
        }
        .padding(12)
        .padding(.bottom, 8)
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
        }
        .sheet(isPresented: $isShowingEntrySheet, onDismiss: {
            addNavBarBackground()
        }) {
            EntryView(entry: entry, isShowingEntrySheet: $isShowingEntrySheet)
                .presentationDragIndicator(.visible)
        }
        
    }
    
    func pullDownButton(entry: Entry) -> some View {
        Menu{
            Button ("Apagar", role: .destructive) {
                isShowingDeleteEntry = true
            }
            Button ("Editar") {
                isShowingEditEntrySheet = true
            }
            
        } label: {
            Image(systemName: "ellipsis")
                .foregroundStyle(.cinzaClaro)
                .font(.system(size: 32, weight: .regular))
        }.confirmationDialog("Tem certeza de que deseja apagar este registro?", isPresented: $isShowingDeleteEntry, titleVisibility: .visible) {
            
            Button ("Apagar Registro", role: .destructive) {
                deleteEntry(entry: entry)
            }
            
            Button ("Cancelar", role: .cancel) {
                
            }
        }.sheet(isPresented: $isShowingEditEntrySheet, onDismiss: {
            addNavBarBackground()
        }) {
            AddEntrySheet(isPresented: $isShowingEditEntrySheet, existingEntry: entry)
                .interactiveDismissDisabled()
        }
    }
    
    func entryComFoto(entry: Entry, photo: Image) -> some View {
        HStack (spacing: 8){
            photo
                .resizable()
                .scaledToFit()
                .mask {
                    RoundedRectangle(cornerRadius: 8)
                }
            
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
            //if let note = entry.note {
            NotePreviewComponent(note: entry.note, isPreview: true)
            //}
            
            if let effects = entry.effects {
                EffectPreviewComponent(effects: effects, isPreview: true)
            }
            
            //if let documents = entry.documents {
            DocumentPreviewComponent(documents: entry.documents, isPreview: true)
            //}
            
        }
    }
    
    func addEntryButton(selectedDate: Date) -> some View {
        Button(action: {
            isShowingAddEntrySheet = true
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
                        .fill(isFutureDate(selectedDate) ?  .cinzaClaro.opacity(0.3) : .rosa)
                }
        }.disabled(isFutureDate(selectedDate))
            .sheet(isPresented: $isShowingAddEntrySheet, onDismiss: {
                addNavBarBackground()
            }) {
                AddEntrySheet(isPresented: $isShowingAddEntrySheet, selectedDate: selectedDate)
                    .interactiveDismissDisabled()
    }
    
    }
    
    // MARK: - DATA  FUNCS
    
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
    
    func remindersTodayAsync(date: Date, reminders: [Reminder]) async -> [Reminder] {
        return await withCheckedContinuation { continuation in
            let result = Repetition.remindersToday(date: date, reminders: reminders)
            continuation.resume(returning: result)
        }
    }

    func loadAllReminders() async {
        isLoadingReminders = true
        for day in monthDates {
            let newReminders = await remindersTodayAsync(date: day, reminders: reminders)
            self.monthReminders[day] = newReminders.sorted(by: { $0.time < $1.time })
        }
        isLoadingReminders = false
    }

    func loadTodayReminders() async {
        isLoadingReminder = true
        let newReminders = await remindersTodayAsync(date: selectedDate, reminders: reminders)
        self.selectedDayReminders = newReminders.sorted(by: { $0.time < $1.time })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isLoadingReminder = false
        }
    }
    
    mutating func incorporateNewReminder(reminder: Reminder) {
        for day in monthDates {
            monthReminders[day]?.append(contentsOf: Repetition.remindersToday(date: day, reminders: [reminder]))
        }
    }
    
    func loadNotifications() {
        var dates: [Date] = []
        let today = Calendar.current.startOfDay(for: Date.now)

        for i in 0...3 {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: today) {
                dates.append(date)
            }
        }
        
        for date in dates {
            if let reminders = monthReminders[date] {
                for reminder in reminders.filter({getDateByDayAndTime(day: date, time: $0.time)?.timeIntervalSinceNow ?? -1 > 0}) {
                    var reminderNotifications = notifications.filter({$0.reminder?.modelID == reminder.modelID})
                    
                    if reminder.type == .event {
                        if !reminderNotifications.contains(where: {$0.type == .afterEvent && isSameDay($0.date, date)}) {
                            sendReminderNotification(reminder: reminder, type: .afterEvent, targetDate: date, modelContext: modelContext)
                            //print("c")
                        }
                        
                        if !reminderNotifications.contains(where: {$0.type == .rememberEvent && isSameDay($0.date, date)}) {
                            sendReminderNotification(reminder: reminder, type: .rememberEvent, targetDate: date, modelContext: modelContext)
                        }
                        
                    } else {
                        
                        if !reminderNotifications.contains(where: {$0.type == .takeMedicine && isSameDay($0.date, date)}) {
                            print("chamada 1")
                            sendReminderNotification(reminder: reminder, type: .takeMedicine, targetDate: date, modelContext: modelContext)
                            
                        }
                        
                        if !reminderNotifications.contains(where: {$0.type == .missingMedicine && isSameDay($0.date, date)}) {
                            sendReminderNotification(reminder: reminder, type: .missingMedicine, targetDate: date, modelContext: modelContext)
                        }
                    }
                    
                }
            }
            
        }
    
    }
    
}

#Preview {
    Diary()
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
