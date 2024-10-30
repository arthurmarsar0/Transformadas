//
//  Diary.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 29/10/24.
//

import SwiftUI
import SwiftData

struct Diary: View {
    ///DATA
    @Environment(\.modelContext) var modelContext
    @Query var entries: [Entry]
    @Query var reminders: [Reminder]
    
    ///VIEW
    @State var selectedDay  = Calendar.current.dateComponents([.day, .month], from: Date.now).day
    
    var currentMonthString: String {
        return Date.now.monthString
    }
    var currentDay: Int {
        return Date.now.dayNumber
    }
    var currentYear: Int {
        return Date.now.yearNumber
    }
    
    var monthDates: [Date] {
        return datesInCurrentMonth()
    }
    
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
    
    func toolbar() -> some View {
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: "plus")
            }
            
            Button(action: {
                
            }) {
                Image(systemName: "calendar")
            }
            
            Button(action: {
                
            }) {
                Image(systemName: "ellipsis.circle")
            }
        }.foregroundStyle(.black)
    }
    
    func todayReminders() -> some View {
        VStack (spacing: 8){
            HStack {
                Text("Para este dia:")
                    .foregroundStyle(.cinzaEscuro)
                Spacer()
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
            ScrollView(.horizontal) {
                HStack (spacing: 8) {
                    ForEach(monthDates, id: \.self) { date in
                        Button(action: {
                            selectedDay = date.dayNumber
                        }) {
                            CarouselDayComponent(date: date, state: .constant(.noEntry), isSelected: selectedDay == date.dayNumber, remindersQuantity: .constant(4))
                                .padding(.vertical, 4)
                        }
                        
                    }
                }
            }
        }
        
    }
    
}

#Preview {
    Diary()
}
