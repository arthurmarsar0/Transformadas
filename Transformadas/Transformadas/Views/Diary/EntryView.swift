//
//  EntryView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 31/10/24.
//

import SwiftUI
import SwiftData

struct EntryView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var audioPlayer: AudioPlayer
    
    
    var entry: Entry
    @Binding var isShowingEntrySheet: Bool
    
    @State var isShowingDeleteEntry: Bool = false
    @State var isShowingEditEntrySheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 16){
                    
                    entryDate()
                    
                    VStack (spacing: 8) {
                        
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(0..<entry.photos.count, id: \.self) { i in
                                    if let photo = EntryModel.dataToImage(data: entry.photos[i]) {
                                        NavigationLink(destination: PhotosView(entryDate: entry.date, photos: EntryModel.dataToImages(dataset: entry.photos), startingPhoto: i)) {
                                            photo
                                                .resizable()
                                                .frame(width: 173, height: 232)
                                                .aspectRatio(contentMode: .fill)
                                                .scaledToFit()
                                                .mask {
                                                    RoundedRectangle(cornerRadius: 8)
                                                }
                                        }
                                        
                                    }
                                }
                            }
                        }
                        
                        
                        
                        
                        if let mood = entry.mood {
                            MoodPreviewComponent(mood: mood, entryDate: entry.date, isPreview: false)
                        }
                        if let audio = entry.audio {
                            AudioPreviewComponent(audio: audio, isPreview: false)
                                .environmentObject(audioPlayer)
                        }
                        
                        if let weight = entry.weight {
                            WeightPreviewComponent(weight: weight, isPreview: false)
                        }
                        //if let note = entry.note {
                        NotePreviewComponent(note: entry.note, isPreview: false)
                        //}
                        
                        
                    }
                    
                    if let effects = entry.effects {
                        EffectPreviewComponent(effects: effects, isPreview: false)
                    }
                    
                   
                    DocumentPreviewComponent(documents: entry.documents, isPreview: false)
                    
                    
                    deleteEntryButton().padding(.top, 16)
                    
                    Spacer()
                }
                .padding(16)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button ("Editar") {
                            isShowingEditEntrySheet = true
                        }.sheet(isPresented: $isShowingEditEntrySheet) {
                            AddEntrySheet(isPresented: $isShowingEditEntrySheet, existingEntry: entry)
                                .interactiveDismissDisabled()
                                .environmentObject(audioPlayer)
                        }
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("OK") {
                            isShowingEntrySheet = false
                        }
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.verde)
                    }
                }
                .toolbarBackground(.white)
                .toolbarBackgroundVisibility(.visible)
            }
        }.onAppear {
            removeNavBarBackground()
        }
    }
    
    func entryDate() -> some View {
        HStack {
            Text("\(entry.date.dayNumber) \(entry.date.monthString.prefix(3)) \(entry.date.yearNumber)")
                .foregroundStyle(.cinzaClaro)
            Spacer()
        }
    }
    
    func deleteEntryButton() -> some View {
        Button(action: {
            isShowingDeleteEntry = true
        }) {
            Text("Apagar Registro")
                .foregroundStyle(.red)
        }.confirmationDialog("Tem certeza de que deseja apagar este registro?", isPresented: $isShowingDeleteEntry, titleVisibility: .visible) {
            
            Button ("Apagar Registro", role: .destructive) {
                deleteEntry(entry: entry)
            }
            
            Button ("Cancelar", role: .cancel) {
                
            }
        }
    }
    
    /// DATA FUNC
    
    func deleteEntry(entry: Entry) {
        modelContext.delete(entry)
        isShowingEntrySheet = false
    }
}

#Preview {
    NavigationStack {
        EntryView(entry: Entry(date: Date.now, mood: .well, note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in ornare tellus. Nunc et tortor quis orci tristique facilisis at eget nisi. Proin at aliquam augue. In pretium risus tortor, vitae mollis leo eleifend eu. Ut lacus mauris, accumsan et fringilla at, bibendum ut urna. Vivamus a sapien eu nunc suscipit aliquet. Sed rutrum et libero eget mattis. Ut ullamcorper enim in dolor dignissim, at facilisis enim lobortis. ", audio: nil, photos: [EntryModel.imageToData(image: UIImage(systemName: "calendar")!)!, EntryModel.imageToData(image: UIImage(systemName: "calendar")!)!, EntryModel.imageToData(image: UIImage(systemName: "calendar")!)!], effects: [Effect(name: "Crescimento das mamas"), Effect(name: "Diminuição de pelos faciais", status: .active), Effect(name: "Fadiga", status: .active), Effect(name: "Insônia", status: .active), Effect(name: "Náusea", status: .active)], documents: [], weight: 63.7), isShowingEntrySheet: .constant(true))
    }
    .modelContainer(for: [Effect.self,
                          User.self,
                          Entry.self,
                          Reminder.self], inMemory: true, isAutosaveEnabled: false)
    
}
