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
//    var day: Entry
    
    @Query var effects: [Effect]
    @Environment(\.modelContext) var modelContext
    
    @State var effectsBool: [Effect:Bool] = [:]
    
    var body: some View {
        NavigationStack{
            ZStack{
                // TODO: Adicionar a cor bege de fundo
                
                List {
                    Section("COMO ESTOU ME SENTINDO?"){
                        moodView()
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
                    }
                    
                    Section("Efeitos"){
                        effectView()
                    }
                    //                .scrollContentBackground(.hidden)
                }
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
//                            self.isPresented.toggle()
                            addEffect()
                        }) {
                            Text("Registrar")
                                .foregroundStyle(Color.red)
                        }
                    }
                }
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
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 56, height: 56)
                        .overlay(content: {
                            Text(mood.emoji)
                                .font(.system(size: 32))
                        })
                        .onTapGesture {
                            print(mood.name)
                        }
                    Text(mood.name)
                        .font(.system(size: 11))
                }
            }
            
        }
        .listRowBackground(Color.clear) //estudar como alterar o frame
    }
    
    func effectView() -> some View {
        ForEach(effects, id: \.self) {effect in
            Text(effect.name)
        }
    }
    
    func addEffect() {
        modelContext.insert(Effect(name: "teste"))
    }
}

#Preview {
    RegisterSheet(isPresented: .constant(true))
}
