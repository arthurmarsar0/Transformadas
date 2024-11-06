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
    
    // MARK: - DATA
    @Query var effects: [Effect]
    
    @Environment(\.modelContext) var modelContext
    
    // MARK: - VIEW DATA
    @State var entry: Entry = Entry(date: Date.now, mood: nil, note: "", audio: nil, photos: [], effects: [], documents: [], weight: nil)
    
    ///EFFECTS
    @State var activeEffects: [Effect] = []
    @State var chosenEffects: [Bool] = []
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
    @State var selectedDocuments: [URL] = []
    @State var selectedDocumentURL: URL?
    
    ///AUDIO
    @State var audioRecorded: Bool = false
    
    var canAddEntry: Bool {
        return entry.mood != nil
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                // TODO: Adicionar a cor bege de fundo
                Color.bege
                    .ignoresSafeArea()
                
                List {
                    Section("COMO ESTOU ME SENTINDO?"){
                        moodView()
                    }
                    
                    Section {
                        TextField("Descreva este momento da sua transição...", text: $entry.note, axis: .vertical)
                            .lineLimit(6...7)
                            .modifier(KeyboardDismiss())
                    }.listSectionSpacing(16)
                    
                    Section("Mudanças Físicas") {
                        audioView()
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
                            Text("Registrar")
                                .foregroundStyle(canAddEntry ? .rosa : .cinzaClaro)
                                .disabled(!canAddEntry)
                                .font(.system(size: 17, weight: .semibold))
                        }
                    }
                }
                .toolbarBackground(.bege)
                .toolbarBackgroundVisibility(.visible)
                
            }
        }.onAppear {
            activeEffects = effects.filter({$0.status != .inactive})
            chosenEffects = Array(repeating: false, count: activeEffects.count)
        }
        .onChange(of: hasEffectsChanged) {
            if hasEffectsChanged {
                hasEffectsChanged = false
                activeEffects = effects.filter({$0.status != .inactive})
                chosenEffects = Array(repeating: false, count: activeEffects.count)
            }
        }
    }
    
    // MARK: - VIEW FUNC
    
    func moodView() -> some View {
        
        return HStack(alignment: .top,spacing: 20){
            ForEach(Mood.allCases, id: \.self){ mood in
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
        Button(action: {
            
        }) {
            HStack {
                Text("Gravar voz")
                Spacer()
                Image(systemName: "microphone.fill")
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
        .sheet(isPresented: $isShowingCameraPicker) {
            CameraPicker(selectedImage: $selectedCameraPhoto, sourceType: .camera)
        }
        .onChange(of: selectedCameraPhoto) {
            if let selectedPhoto = selectedCameraPhoto {
                selectedPhotosCamera.append(selectedPhoto)
                selectedCameraPhoto = nil
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
        }
    }
    
    func effectView() -> some View {
        ForEach(0..<chosenEffects.count, id: \.self) { i in
            Toggle(isOn: $chosenEffects[i]) {
                Text(activeEffects[i].name)
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
                            Image(systemName: "xmark.circle")
                                .foregroundStyle(.black)
                        }
                    }
                    
                }
            }
        }
    }
    
    func addEffectButton() -> some View {
        NavigationLink(destination: ManageEffectsView(hasEffectsChanged: $hasEffectsChanged).navigationBarBackButtonHidden()) {
            
            Text("Adicione um Efeito")
                .foregroundStyle(.rosa)
            
        }
    }
    
    
    func pdfView() -> some View {
        ForEach(selectedDocuments, id: \.self) { document in
            HStack (spacing: 16){
                Text(document.pathExtension)
                    .foregroundStyle(.blue)
                    .background {
                        Image(systemName: "document.fill")
                            .foregroundStyle(.beginho)
                            .font(.system(size: 48))
                    }
                Text(document.lastPathComponent)
                
                Button(action: {
                    selectedDocuments.removeAll(where: {$0 == document})
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.gray)
                }
                
            }
            
        }
        .sheet(isPresented: $isShowingDocumentPicker) {
            DocumentPicker(selectedURL: $selectedDocumentURL)
        }
        .onChange(of: selectedDocumentURL) {
            if let document = selectedDocumentURL {
                selectedDocuments.append(document)
                selectedDocumentURL = nil
            }
            
        }
    }
    
    // MARK: - DATA FUNC
    
    func addRegister() {
        for i in activeEffects.indices {
            if chosenEffects[i] {
                entry.effects?.append(activeEffects[i])
            }
        }
        
        for photo in selectedPhotos {
            if let data = EntryModel.imageToData(image: photo) {
                entry.photos.append(data)
            }
        }
        
        entry.documents = selectedDocuments.map({Document(name: $0.lastPathComponent, url: $0)})
        
        
        modelContext.insert(entry)
    }
    
}

#Preview {
    AddEntrySheet(isPresented: .constant(true))
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
