//
//  PhotoAlbumView.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 07/11/24.
//

import SwiftUI
import SwiftData

struct PhotoAlbumView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Query var entries: [Entry]
    
    @State var firstDate: Date = .distantPast
    @State var lastDate: Date = .distantFuture
    
    var allEntriesSorted : [Entry] {
        return entries.sorted(by: {$0.date < $1.date})
    }
    
    var filteredAllEntries : [Data] { allEntriesSorted.flatMap(\.photos) }
    
    @State var months : [Date] = []
    
    let columns = [
        GridItem(.adaptive(minimum: 84))
    ]
    
    var body: some View {
        ZStack{
            Color.bege
                .ignoresSafeArea()
            VStack {
                HStack{
                    Text("Minhas Fotos")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(.marrom)
                    Spacer()
                }
                ScrollView {
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
                            }.flatMap{ entry in
                                entry.photos.map { photo in
                                    (entry.date, photo)
                                }
                            }
                        
                            
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(filteredEntries.indices, id: \.self) { i in
                                    if let image = EntryModel.dataToImage(data: filteredEntries[i].1) {
                                        NavigationLink(destination: {
                                            PhotosJourneyView(photos: filteredEntries, startingPhoto: i)
                                                .navigationBarBackButtonHidden()
                                        }) {
                                            image
                                                .resizable()
                                                .frame(width: 84, height: 84)
                                                .aspectRatio(contentMode: .fit)
                                                .mask {
                                                    RoundedRectangle(cornerRadius: 8)
                                                }
                                        }
                                    }
                                            
                                }
                            }
                        }
                        .padding(.top, 16)
                    }
                }
            }
            .padding(16)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        HStack{
                            Image(systemName: "chevron.left")
                            Text("Voltar")
                        }
                        .foregroundStyle(.preto)
                    }
                }
            }
            .onAppear() {
                lastDate = entries.sorted(by: {
                    $0.date < $1.date}).last?.date ?? Date.distantFuture
                firstDate = entries.sorted(by: {
                    $0.date < $1.date}).first?.date ?? Date.distantPast
                
                if firstDate != Date.distantPast && lastDate != Date.distantFuture {
                    months = monthsInBetween(firstDate, lastDate)
                }
                
            }
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
    PhotoAlbumView()
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}



