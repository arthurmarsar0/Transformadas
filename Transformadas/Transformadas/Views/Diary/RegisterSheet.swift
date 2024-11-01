//
//  RegisterSheet.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 01/11/24.
//

import SwiftUI
import SwiftData


struct RegisterSheet: View {
    @Binding var isPresented: Bool
    //    @Binding var details: String
    @State var audioRecorded: Bool = false
//    @State var day: Entry = .init(
    
    
    @State var moodChosen: Mood?
    
    @Query var effects: [Effect]
    @Environment(\.modelContext) var modelContext
    
    @State var effectsBool: [Effect:Bool] = [:]
    @State var pdfNames: [String] = []
    
    var body: some View {
        NavigationStack{
            ZStack{
                // TODO: Adicionar a cor bege de fundo
                Color.rosa
                
                List {
                    Section("COMO ESTOU ME SENTINDO?"){
                        moodView()
                    }
                    
                    Section{
                       Text("teste") //adição do text field para escrever
                    }
                    
                    Section("Mudanças Físicas") {
                        Button(action: {}, label:{
                            HStack {
                                Text("Gravar voz")
                                Spacer()
                                Image(systemName: "microphone.fill")
                            }
                            .foregroundStyle(Color.gray)
                        })
                    }
                    
                    Section{
                        Button(action: {}, label:{
                            Text("Tirar Foto")
                        })
                       
                        Button(action: {},
                               label: {
                            HStack {
                                
                                Text("Escolher Imagem Existente")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        })
                        //TODO: Ver como fica se mais de uma foto for adicionada
                    }
                    .foregroundStyle(Color.gray)
                    
                    Section("Efeitos"){
                        effectView()
                    }
                    
                    Section("Arquivos anexos"){
                        pdfView()
                        Button(action: {
                            
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
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.isPresented.toggle()
                        }) {
                            Text("Cancelar")
                                .foregroundStyle(Color.black)
                        }
                    }
                    
                    ToolbarItem {
                        Button(action: {
                            self.isPresented.toggle()
//                            addEffect()
                            print(moodChosen!)
                        }) {
                            Text("Registrar")
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                .toolbarBackground(.bege)
                .toolbarBackgroundVisibility(.visible)
                
            }
        }.onAppear {
            for effect in effects {
                effectsBool[effect] = false
            }
        }
        .onChange(of: effects) {
            for effect in effects {
                effectsBool[effect] = false
            }
        }
    }
    
    func moodView() -> some View {
        
        return HStack(alignment: .top,spacing: 20){
            ForEach(Mood.allCases, id: \.self){ mood in
                VStack{
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(moodChosen == mood ? Color.red : .clear, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .fill(.white.opacity(0.5)) //ver como fazer a troca de cor
                        .frame(width: 56, height: 56)
                        .overlay(content: {
                            Text(mood.emoji)
                                .font(.system(size: 32))
                        })
                        .onTapGesture {
                            print(mood.name)
                            moodChosen = mood
//                            day.mood = mood
                        }
                    Text(mood.name)
                        .font(.system(size: 11))
                        .foregroundStyle(moodChosen == mood ? .blue : .black)
                }
            }
            
        }
        .listRowBackground(Color.clear)
        .frame(height: 88)
        // TODO: alterar o tamanho do frame de uma forma que se aumentar o tamanho da fonte ainda fique esteticamente legal
        
    }
    
    func effectView() -> some View {
        ForEach(effects, id: \.self) {effect in
            Text(effect.name)
        }
    }
    
    func addEffect() { //Consultar com Pv como ele fez
        modelContext.insert(Effect(name: "teste"))
    }
    
    func addRegister() { //salvar o registro no ngc
        
    }
    
    func pdfView() -> some View {
        ForEach(pdfNames, id: \.self) {register in
            Text(register)
        }
    }
}

#Preview {
    RegisterSheet(isPresented: .constant(true))
}
