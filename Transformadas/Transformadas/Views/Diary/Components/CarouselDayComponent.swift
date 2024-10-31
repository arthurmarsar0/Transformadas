//
//  CarouselDayComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 29/10/24.
//

import SwiftData
import SwiftUI

var strokeStyle: StrokeStyle =
StrokeStyle(
    lineWidth: 1,
    lineCap: .butt,
    lineJoin: .miter,
    miterLimit: 28.96,
    dash: [2, 2],
    dashPhase: 0
)

enum DayComponentState {
    case noEntry
    case withEntry
    case future
    case todayNoEntry
    case todayWithEntry
}

struct CarouselDayComponent: View {
    var date: Date
    var dayOfTheWeek: String {
        date.dayOfWeekString.prefix(3).uppercased()
    }
    var day: Int {
        date.dayNumber
    }
    
    var state: DayComponentState
    var isSelected: Bool
    var todayReminders: [Reminder]
    
    var body: some View {
        
        VStack (spacing: 6){
            structure()
                .overlay {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(.rosaMedio, lineWidth: 2)
                            .padding(-2)
                    }
                    
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.bege, lineWidth: 2)
                        
                }
            if (todayReminders.count > 0) {
                reminders()
            }
        }
        
        
        
    }
    
    func reminders() -> some View {
            HStack (spacing: 4) {
                ForEach(todayReminders, id: \.self) { reminder in
                    
                    Circle().fill(reminder.repetition.frequency == 0 ? .azul :
                        .rosa).frame(width: 4, height: 4)
                    
                }
            }
    }
    
    func structure() -> some View {
        switch state {
        case .noEntry:
            AnyView(
                VStack (spacing: 12){
                    Text(dayOfTheWeek)
                        .foregroundStyle(.marrom)
                        .font(.system(size: 12, weight: .medium))
                    
                    Text(String(day)).foregroundStyle(.azul)
                        .frame(width: 32, height: 32)
                    
                    
                }.padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 16).fill(.ultraThinMaterial)
                    }
                    
                
            )
        case .withEntry:
            AnyView(
                VStack (spacing: 12){
                    Text(dayOfTheWeek)
                        .foregroundStyle(.marrom)
                        .font(.system(size: 12, weight: .medium))
                    
                    ZStack {
                        Circle()
                            .fill(.verdeMedio)
                            .frame(width: 32, height: 32)
                        Text(String(day))
                            .foregroundStyle(.white)
                    }
                    
                }.padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 16).fill(.ultraThinMaterial)
                    }
                
            )
        case .future:
            AnyView(
                VStack (spacing: 12){
                    Text(dayOfTheWeek)
                        .foregroundStyle(.marrom)
                        .font(.system(size: 12, weight: .medium))
                    
                    Text(String(day)).foregroundStyle(.cinzaEscuro)
                        .frame(width: 32, height: 32)
                    
                    
                }.padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 16).fill(.ultraThinMaterial)
                    }
                
            )
        case .todayNoEntry:
            AnyView(
                VStack (spacing: 12){
                    Text(dayOfTheWeek)
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .medium))
                    
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.7))
                            .overlay {
                                Circle()
                                    .stroke(.white, style: strokeStyle)
                            }
                            .frame(width: 32, height: 32)
                        Text(String(day))
                            .foregroundStyle(.vermelho)
                    }
                    
                }.padding(8)
                    .background{
                        RoundedRectangle(cornerRadius: 16)
                            .fill(degradeRosa())
                    }
                
            )
        case .todayWithEntry:
            AnyView(
                VStack (spacing: 12){
                    Text(dayOfTheWeek)
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .medium))
                    
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 32, height: 32)
                        Text(String(day))
                            .foregroundStyle(.vermelho)
                    }
                    
                }.padding(8)
                    .background{
                        RoundedRectangle(cornerRadius: 16)
                            .fill(degradeRosa())
                    }
                
            )
            
        }
    }
}

#Preview {
    CarouselDayComponent(date: Date.now, state: .noEntry, isSelected: true, todayReminders: [])
}
