//
//  AllDocumentsView.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 08/11/24.
//

// TODO: Adicionar a abertura de cada documento (trocar a VStack para um Button)

import SwiftUI
import SwiftData

struct AllDocumentsView: View {
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
    
    var filteredAllEntries : [Document] { allEntriesSorted.flatMap(\.documents) }
    
    @State var months : [Date] = []
    
    var body: some View {
        ZStack{
            Color.bege
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Text("Meus Arquivos")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(.marrom)
                    Spacer()
                }
                ScrollView{
                    if filteredAllEntries.isEmpty {
                        Text("Nenhum arquivo encontrado")
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
                            }.flatMap(\.documents)
                            
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(filteredEntries, id: \.self) { document in
                                    VStack (spacing: 4){
                                        Image(systemName: "document.fill")
                                            .font(.system(size: 32))
                                            .foregroundStyle(.rosaMedio)
                                        Text(document.name)
                                            .font(.system(size: 11, weight: .regular))
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(1...2)
                                            .truncationMode(.tail)
                                            .foregroundStyle(.cinzaEscuro)
                                    }
                                }
                            }
                        }
                        .padding(.top, 16)
                    }
                }
            }
            .padding()
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
}

#Preview {
    AllDocumentsView()
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
