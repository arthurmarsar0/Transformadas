//
//  RegisterSheet.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 01/11/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddEntrySheet: View {
    // MARK: - EXTERNAL
    @Binding var isPresented: Bool
    var existingEntry: Entry?
    var selectedDate: Date?
    
    // MARK: - DATA
    @Query var effects: [Effect]
    
    @Environment(\.modelContext) var modelContext
    
    // MARK: - VIEW DATA
    @State var entry: Entry = Entry(date: Date.now, mood: nil, note: "", audio: nil, photos: [], effects: [], documents: [], weight: nil)
    
    var addTitle: String {
        if existingEntry != nil {
            return "Salvar"
        } else {
            return "Registrar"
        }
    }
    
    private var weightFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter
        }
    
    @State private var formattedWeight: String = ""
    
    ///EFFECTS
    @State var activeEffects: [UUID: Bool] = [:]
    //@State var chosenEffects: [Bool] = []
    @State var hasEffectsChanged: Bool = false
    
    ///PHOTOS
    @State var selectedPhotos: [UIImage] = []
    @State var selectedPhotosPPI: [PhotosPickerItem] = []
    @State var selectedPhotosPicker: [UIImage] = []
    @State var selectedPhotosCamera: [UIImage] = []
    @State var isShowingCameraPicker: Bool = false
    @State var selectedCameraPhoto: UIImage?
    
    ///DOCUMENTS
    @State var isShowingDocumentPicker: Bool = false
    @State var selectedDocuments: [Document] = []
    @State var selectedDocumentURL: URL?
    
    ///AUDIO
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isShowingRecordAudioSheet = false
    @StateObject var audioRecorder = AudioRecorder()
    @EnvironmentObject var audioPlayer: AudioPlayer
    @State var isShowingDeleteAudioConfirmation = false
    
    @State var timeElapsed: TimeInterval = 0
    @State var startDate = Date.now
    
    var canAddEntry: Bool {
        return entry.mood != nil
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.bege
                    .ignoresSafeArea()
                
                List {
                    Section("COMO ESTOU ME SENTINDO?"){
                        moodView()
                    }
                    
                    Section {
                        TextField("Descreva este momento da sua transição...", text: $entry.note, axis: .vertical)
                            .lineLimit(6...7)
                        
                    }.listSectionSpacing(16)
                    
                    Section("Mudanças Físicas") {
                        audioView()
                        HStack {
                            Text("Peso:")
                            TextField("", value: $entry.weight, formatter: weightFormatter)
                                .keyboardType(.decimalPad)
                        }
                        
                    }
                    
                    //Section {
                    addImageView()
                    //}
                    //.listSectionSpacing(8)
                    
                    Section {
                        photosCarousel()
                    }.listRowBackground(Color.clear)
                    
                    
                    Section("Efeitos"){
                        effectView()
                    }
                    Section {
                        addEffectButton()
                    }.listSectionSpacing(4)
                    
                    Section("Arquivos anexos") {
                        pdfView()
                        
                        Button(action: {
                            isShowingDocumentPicker = true
                        }, label: {
                            Text("Adicionar anexo...")
                        })
                        .foregroundStyle(Color.gray)
                        
                    }
                    
                    
                }
                .scrollContentBackground(.hidden)
                
                
            }
            .navigationTitle("Seu Dia")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancelar")
                            .foregroundStyle(Color.black)
                    }
                }
                
                ToolbarItem (placement: .confirmationAction){
                    Button(action: {
                        isPresented = false
                        addRegister()
                    }) {
                        Text(addTitle)
                            .foregroundStyle(canAddEntry ? .rosa : .cinzaClaro)
                            .disabled(!canAddEntry)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
            }
            .toolbarBackground(.bege)
            .toolbarBackgroundVisibility(.visible)
            .modifier(KeyboardDismiss())
            .onAppear {
                removeNavBarBackground()
                if let selectedDate = selectedDate {
                    entry.date = selectedDate
                }
                
                
                for effect in effects.filter({$0.status != .inactive}) {
                    activeEffects[effect.modelID] = false
                }
                
                if let existingEntry = existingEntry {
                    selectedDocuments = existingEntry.documents
                    selectedPhotos = EntryModel.dataToImages(dataset: existingEntry.photos)
                    copyEntry(toEntry: entry, entry: existingEntry)
                    
                    if let efs = existingEntry.effects {
                        for effect in efs {
                            activeEffects[effect.modelID] = true
                        }
                    }
                    
                }
                
            }
            .onChange(of: hasEffectsChanged) {
                if hasEffectsChanged {
                    hasEffectsChanged = false
                    for effect in effects.filter({$0.status != .inactive}) {
                        if activeEffects[effect.modelID] == nil {
                            activeEffects[effect.modelID] = false
                        }
                    }
                    
                    for (modelID, _) in activeEffects {
                        if !effects.contains(where: {$0.modelID == modelID}) || effects.filter({$0.modelID == modelID}).first?.status == .inactive {
                            activeEffects.removeValue(forKey: modelID)
                        }
                    }
                }
            }.sheet(isPresented: $isShowingCameraPicker) {
                //CameraPicker(selectedImage: $selectedCameraPhoto, sourceType: .camera)
                //                .onAppear {
                //                    removeNavBarBackground()
                //                }
                ImagePicker(image: $selectedCameraPhoto, sourceType: .camera)
                    .onAppear {
                        removeNavBarBackground()
                    }
            }.sheet(isPresented: $isShowingDocumentPicker) {
                DocumentPicker(selectedURL: $selectedDocumentURL)
                    .onAppear {
                        removeNavBarBackground()
                    }
            }.sheet(isPresented: $isShowingRecordAudioSheet, onDismiss: {
                if audioRecorder.isRecording {
                    entry.audio = audioRecorder.stopRecording()
                }
            }) {
                AudioRecordingSheet(audioRecorder: audioRecorder, isShowingRecordAudioSheet: $isShowingRecordAudioSheet, audio: $entry.audio)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }.confirmationDialog("Você tem certeza que quer deletar o áudio?", isPresented: $isShowingDeleteAudioConfirmation, titleVisibility: .visible) {
                Button ("Deletar", role: .destructive) {
                    entry.audio = nil
                }
                
                Button ("Manter", role: .cancel) {
                    
                }
            }.onChange(of: selectedCameraPhoto) {
                if let selectedPhoto = selectedCameraPhoto {
                    selectedPhotosCamera.append(selectedPhoto)
                    selectedCameraPhoto = nil
                    
                    selectedPhotos = selectedPhotosCamera + selectedPhotosPicker
                }
            }
            .onChange(of: selectedPhotosPPI) {
                Task {
                    selectedPhotosPicker = []
                    for photo in selectedPhotosPPI {
                        
                        guard let imageData = try? await photo.loadTransferable(type: Data.self) else { return }
                        if let convertedImage = UIImage(data: imageData) {
                            selectedPhotosPicker.append(convertedImage)
                        }
                        
                    }
                    selectedPhotos = selectedPhotosCamera + selectedPhotosPicker
                }
            }.onChange(of: selectedDocumentURL) {
                if let documentURL = selectedDocumentURL {
                    var document = Document(name: documentURL.lastPathComponent, url: documentURL, type: documentURL.pathExtension)
                    selectedDocuments.append(document)
                    selectedDocumentURL = nil
                }
                
            }
        }
    }
    
    // MARK: - VIEW FUNC
    
    func moodView() -> some View {
        
        return HStack(alignment: .top,spacing: 20){
            ForEach(Mood.allCases.reversed(), id: \.self){ mood in
                VStack {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(entry.mood == mood ? Color.rosa : .clear, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .fill(.white.opacity(0.5)) //ver como fazer a troca de cor
                        .frame(width: 56, height: 56)
                        .overlay(content: {
                            Text(mood.emoji)
                                .font(.system(size: 32, weight: .semibold))
                        })
                        .onTapGesture {
                            entry.mood = mood
                        }
                    Text(mood.name)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(entry.mood == mood ? .rosa : .cinzaEscuro)
                }
            }
            
        }
        .listRowBackground(Color.clear)
        .frame(height: 88)
        // TODO: alterar o tamanho do frame de uma forma que se aumentar o tamanho da fonte ainda fique esteticamente legal
        
    }
    
    func audioView() -> some View {
        Section {
            if let audio = entry.audio {
                AnyView(
                    HStack (spacing: 24){
                        
                        if !audioPlayer.isPlaying {
                            Image(systemName: "play.fill")
                                .foregroundStyle(.rosa)
                                .onTapGesture {
                                    if audioPlayer.isStarted {
                                        audioPlayer.playPlayback()
                                    } else {
                                        audioPlayer.startPlayback(audio: audio)
                                    }
                                }
                            
                        } else {
                            
                            Image(systemName: "pause.fill")
                                .foregroundStyle(.rosa)
                                .onTapGesture {
                                    audioPlayer.pausePlayback()
                                }
                            
                        }
                        
                        if audioPlayer.isStarted {
                            Text(audioPlayer.currentTime.minutesAndSeconds)
                        } else {
                            Text(audio.length.minutesAndSeconds)
                        }
                        
                        
                        
                        ///TO-DO: AUDIO WAVELENGTH
                        
                        Spacer()
                        
                        
                        Image(systemName: "trash.circle.fill")
                            .foregroundStyle(.gray)
                            .onTapGesture {
                                isShowingDeleteAudioConfirmation = true
                                
                            }
                    }
                )
            } else {
                AnyView(
                    Button(action: {
                        isShowingRecordAudioSheet = true
                    }) {
                        HStack {
                            Text("Gravar voz")
                            Spacer()
                            Image(systemName: "microphone.fill")
                        }
                    }
                )
            }
        }
        
    }
    
    func addImageView() -> some View {
        Section {
            Button(action: {
                isShowingCameraPicker = true
            }){
                Text("Tirar Foto")
            }
            
            PhotosPicker(selection: $selectedPhotosPPI, matching: .images) {
                Label("Escolher Imagem Existente", systemImage: "photo")
            }
        }
        .listSectionSpacing(8)
        
    }
    
    func effectView() -> some View {
        ForEach(activeEffects.keys.sorted(), id: \.self) { modelID in
            let isOn = Binding<Bool>(
                get: { activeEffects[modelID] ?? false },
                set: { newValue in activeEffects[modelID] = newValue }
            )
            
            Toggle(isOn: isOn) {
                Text(effects.filter{$0.modelID == modelID}.first?.name ?? "")
            }
        }
    }
    
    func photosCarousel() -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(selectedPhotos, id: \.self) { photo in
                    ZStack (alignment: .topTrailing){
                        Image(uiImage: photo)
                            .resizable()
                            .frame(width: 173, height: 232)
                            .aspectRatio(contentMode: .fill)
                            .scaledToFit()
                            .mask {
                                RoundedRectangle(cornerRadius: 8)
                            }
                        Button(action: {
                            selectedPhotos.removeAll(where: { $0 == photo })
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.white)
                        }
                    }
                    
                }
            }
        }
    }
    
    func addEffectButton() -> some View {
        NavigationLink(destination: ManageEffectsView(hasEffectsChanged: $hasEffectsChanged).navigationBarBackButtonHidden()) {
            
            Text("Adicione um Efeito")
                .foregroundStyle(.verde)
            
        }
    }
    
    
    func pdfView() -> some View {
        ForEach(selectedDocuments, id: \.self) { document in
            HStack (spacing: 16){
                Text(document.type)
                    .foregroundStyle(.blue)
                    .background {
                        Image(systemName: "document.fill")
                            .foregroundStyle(.beginho)
                            .font(.system(size: 48))
                    }
                Text(document.name)
                
                Button(action: {
                    selectedDocuments.removeAll(where: {$0 == document})
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.gray)
                }
                
            }
            
        }
        
        
    }
    
    // MARK: - DATA FUNC
    
    func addRegister() {
        if let existingEntry = existingEntry {
            copyEntry(toEntry: existingEntry, entry: entry)
            existingEntry.effects = []
            existingEntry.documents = []
            existingEntry.photos = []
            
            for (modelID, isOn) in activeEffects {
                if let effect = effects.filter({$0.modelID == modelID}).first, isOn {
                    existingEntry.effects?.append(effect)
                }
            }
            
            for photo in selectedPhotos {
                if let data = EntryModel.imageToData(image: photo) {
                    existingEntry.photos.append(data)
                }
            }
            
            for document in selectedDocuments {
                if let url = saveDocumentToAppDirectory(url: document.url) {
                    existingEntry.documents.append(Document(name: document.name, url: url, type: document.type))
                }
            }
            
            print("registro editado com sucesso!")
        } else {
            var newEntry = Entry(date: Calendar.current.startOfDay(for: entry.date), mood: entry.mood, note: entry.note, audio: entry.audio, photos: [], effects: [], documents: [], weight: entry.weight)
            
            for (modelID, isOn) in activeEffects {
                if let effect = effects.filter({$0.modelID == modelID}).first, isOn {
                    newEntry.effects?.append(effect)
                }
            }
            
            for photo in selectedPhotos {
                if let data = EntryModel.imageToData(image: photo) {
                    newEntry.photos.append(data)
                }
            }
            
            for document in selectedDocuments {
                if let url = saveDocumentToAppDirectory(url: document.url) {
                    newEntry.documents.append(Document(name: document.name, url: url, type: document.type))
                }
            }
            
            modelContext.insert(newEntry)
            print("registro criado com sucesso!")
        }
    }
    
}

#Preview {
    AddEntrySheet(isPresented: .constant(true), selectedDate: (Date.now))
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
