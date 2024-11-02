//
//  EntryView.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 31/10/24.
//

import SwiftUI

struct EntryView: View {
    @Environment(\.modelContext) var modelContext
    
    
    var entry: Entry
    @Binding var isShowingEntrySheet: Bool
    
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
                                                .scaledToFill()
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
                        }
                        
                        if let weight = entry.weight {
                            WeightPreviewComponent(weight: weight, isPreview: false)
                        }
                        if let note = entry.note {
                            NotePreviewComponent(note: note, isPreview: false)
                        }
                        
                        
                    }
                    
                    if let effects = entry.effects {
                        //EffectPreviewComponent(effects: effects, isPreview: false)
                    }
                    
                    if let documents = entry.documents {
                        DocumentPreviewComponent(documents: documents, isPreview: false)
                    }
                    
                    deleteEntryButton().padding(.top, 16)
                    
                    Spacer()
                }
                .padding(16)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Editar") {
                            
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
            }
        }
        .navigationBarWithImageBackground(createWhiteImage(size: CGSizeMake(100, 100)))
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
            deleteEntry(entry: entry)
        }) {
            Text("Apagar Registro")
                .foregroundStyle(.red)
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
        EntryView(entry: Entry(date: Date.now, mood: .well, note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in ornare tellus. Nunc et tortor quis orci tristique facilisis at eget nisi. Proin at aliquam augue. In pretium risus tortor, vitae mollis leo eleifend eu. Ut lacus mauris, accumsan et fringilla at, bibendum ut urna. Vivamus a sapien eu nunc suscipit aliquet. Sed rutrum et libero eget mattis. Ut ullamcorper enim in dolor dignissim, at facilisis enim lobortis. ", audio: "", photos: [EntryModel.imageToData(image: UIImage(systemName: "calendar")!)!, EntryModel.imageToData(image: UIImage(systemName: "calendar")!)!, EntryModel.imageToData(image: UIImage(systemName: "calendar")!)!], effects: [Effect(name: "Crescimento das mamas"), Effect(name: "Diminuição de pelos faciais"), Effect(name: "Fadiga"), Effect(name: "Insônia"), Effect(name: "Náusea")], documents: [], weight: 63.7), isShowingEntrySheet: .constant(true))
    }
}
