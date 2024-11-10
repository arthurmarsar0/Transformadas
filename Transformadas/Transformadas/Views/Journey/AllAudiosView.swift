//
//  AllAudiosView.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 08/11/24.
//

// TODO: tentar chamar a oneAudioView no ForEach sem causar o erro

import SwiftUI
import SwiftData

struct AllAudiosView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Query var allEntries: [Entry]
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var firstDate: Date {
        return allEntries.sorted(by: {
            $0.date < $1.date}).first?.date ?? Date.distantPast
    }
    
    var lastDate: Date {
        return allEntries.sorted(by: {
            $0.date < $1.date}).last?.date ?? Date.distantFuture
    }
    
    var allEntriesSorted : [Entry] {
        return allEntries.sorted(by: {$0.date < $1.date})
    }
    
    var filteredAllEntries : [Audio] { allEntriesSorted.flatMap(\.audio) }
    
    @State var months : [Date] = []
    
    var body: some View {
        ZStack{
            Color.bege
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Meus Áudios")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(.marrom)
                    Spacer()
                }
                ScrollView{
                    if filteredAllEntries.isEmpty {
                        Text("Nenhum áudio encontrado")
                            .foregroundStyle(.cinzaEscuro)
                    } else {
                        ForEach(months, id: \.self) { date in
                            HStack{
                                Text(date.monthString.capitalized + " " + String(date.yearNumber))
                                    .font(.system(size:15 , weight: .regular))
                                    .foregroundStyle(.cinzaEscuro)
                                Spacer()
                            }
                            let filteredEntries = allEntriesSorted.filter {
                                $0.date.monthNumber == date.monthNumber && $0.date.yearNumber == date.yearNumber
                            }
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(filteredEntries, id: \.self) { entrada in
                                    Text("teste") //o erro de compilador é de acordo como isso roda
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundStyle(.preto)
                }
            }
        }
        .onAppear() {
            months = monthsInBetween(firstDate, lastDate)
        }
    }
    
    func monthsInBetween(_ start: Date,_ end: Date) -> [Date] {
        var months: [Date] = []
        var currentMonth: Date = start
        while currentMonth.monthNumber <= end.monthNumber {
            months.append(currentMonth)
            currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth)!
        }
        return months.reversed()
    }
    
    func oneAudioView(_ audio: Audio) -> some View {
        HStack{
            VStack (spacing: 8){
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.branco)
                VStack{
                    Text("00:15")
                        .font(.system(size: 11))
                        .foregroundStyle(.branco)
                    Image(systemName: "waveform")
                        .font(.system(size: 11))
                        .foregroundStyle(.branco)
                    
                }
            }
            Spacer()
        }
        .padding(8)
        .frame(width: 84, height: 84)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(.verdeMedio)
        }
    }
}

#Preview {
    AllAudiosView()
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
